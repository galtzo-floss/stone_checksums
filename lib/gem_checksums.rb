# frozen_string_literal: true

# Std lib
require "digest/sha2"
require "fileutils"

# external gems
require "version_gem"

# this library's version
require_relative "gem_checksums/version"

# Primary namespace of this library
module GemChecksums
  # Errors raised by this gem will use this class
  class Error < StandardError; end

  # Final clause of Regex `(?=\.gem)` is a positive lookahead assertion
  # See: https://learnbyexample.github.io/Ruby_Regexp/lookarounds.html#positive-lookarounds
  # Used to pattern match against a gem package name, which always ends with .gem.
  # The positive lookahead ensures it is present, and prevents it from being captured.
  VERSION_REGEX = /((\d+\.\d+\.\d+)([-.][0-9A-Za-z-]+)*)(?=\.gem)/.freeze
  RUNNING_AS = File.basename($PROGRAM_NAME)
  BUILD_TIME_ERROR_MESSAGE = "Environment variable SOURCE_DATE_EPOCH must be set. You'll need to rebuild the gem. See README.md of stone_checksums"
  GIT_DRY_RUN_ENV = ENV.fetch("GEM_CHECKSUMS_GIT_DRY_RUN", "false").casecmp("true") == 0
  CHECKSUMS_DIR = ENV.fetch("GEM_CHECKSUMS_CHECKSUMS_DIR", "checksums")
  PACKAGE_DIR = ENV.fetch("GEM_CHECKSUMS_PACKAGE_DIR", "pkg")
  BUILD_TIME_WARNING = <<~BUILD_TIME_WARNING
    WARNING: Build time not provided via environment variable SOURCE_DATE_EPOCH.
             When using Bundler < 2.7.0, you must set SOURCE_DATE_EPOCH *before* building
             the gem to ensure consistent SHA-256 & SHA-512 checksums.
    
    PREFERRED: Upgrade to Bundler >= 2.7.0, which uses a constant timestamp for gem builds,
               making SOURCE_DATE_EPOCH unnecessary for reproducible checksums.
    
    IMPORTANT: If you choose to set the build time via SOURCE_DATE_EPOCH,
               you must re-build the gem, i.e. `bundle exec rake build` or `gem build`.
    
    How to set the build time (only needed for Bundler < 2.7.0):
    
    In zsh shell:
      - export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH
      - If the echo above has no output, then it didn't work.
      - Note that you'll need the `zsh/datetime` module enabled.
    
    In fish shell:
      - set -x SOURCE_DATE_EPOCH (date +%s)
      - echo $SOURCE_DATE_EPOCH
    
    In bash shell:
      - export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH
    
  BUILD_TIME_WARNING

  # Make this gem's rake tasks available in your Rakefile:
  #
  #   require "gem_checksums"
  #
  # @return [void]
  def install_tasks
    load("gem_checksums/tasks.rb")
  end
  module_function :install_tasks

  # Script, stolen from myself, from https://github.com/rubygems/guides/pull/325
  # NOTE (Bundler < 2.7.0): SOURCE_DATE_EPOCH must be set in your environment prior to building the gem.
  #       Bundler >= 2.7.0 uses a constant timestamp internally, so SOURCE_DATE_EPOCH is no longer required.
  #       This ensures that the gem build, and the gem checksum will use the same timestamp,
  #       and thus will match the SHA-256 checksum generated for every gem on Rubygems.org.
  # Generate SHA-256 and SHA-512 checksums for a built .gem and commit them.
  #
  # Behavior regarding reproducible builds depends on Bundler version:
  # - Bundler >= 2.7.0: SOURCE_DATE_EPOCH is not required; Bundler uses a constant timestamp.
  # - Bundler < 2.7.0: you must set SOURCE_DATE_EPOCH, or upgrade Bundler. If
  #   GEM_CHECKSUMS_ASSUME_YES=true is set, the check proceeds non-interactively, but
  #   SOURCE_DATE_EPOCH is still required.
  #
  # The generated checksum files are written to the directory configured via
  # GEM_CHECKSUMS_CHECKSUMS_DIR (default: "checksums"). By default, the newest .gem in
  # GEM_CHECKSUMS_PACKAGE_DIR (default: "pkg") is used, unless a specific .gem path is
  # passed as the first CLI argument when running under Rake or the gem_checksums CLI.
  #
  # By default this command will exec a `git add && git commit` to include the checksum
  # files. When `git_dry_run` is true, or GEM_CHECKSUMS_GIT_DRY_RUN=true, a dry-run commit
  # is performed, and temporary files are cleaned up.
  #
  # @param git_dry_run [Boolean] when true, perform a dry-run and do not leave files staged
  # @return [void]
  def generate(git_dry_run: false)
    git_dry_run_flag = (git_dry_run || GIT_DRY_RUN_ENV) ? "--dry-run" : nil
    warn("Will run git commit with --dry-run") if git_dry_run_flag

    # Header: identify the gem and version being run
    begin
      puts "[ stone_checksums #{::StoneChecksums::Version::VERSION} ]"
    rescue StandardError
      # If for any reason the version constant isn't available, skip header gracefully
    end

    # Bundler version gate for reproducibility requirements
    bundler_ver = Gem::Version.new(Bundler::VERSION)

    requires_epoch = bundler_ver < Gem::Version.new("2.7.0")

    if requires_epoch
      # For older bundler, ask the user whether to proceed, or quit to update.
      proceed = ENV.fetch("GEM_CHECKSUMS_ASSUME_YES", "").casecmp("true").zero?

      unless proceed
        # Non-interactive prompt: advise and abort
        prompt_msg = <<~PROMPT
          Detected Bundler #{bundler_ver || "(unknown)"} which is older than 2.7.0.
          For reproducible builds without SOURCE_DATE_EPOCH, please update Bundler to >= 2.7.0.
          If you still want to proceed with this older Bundler, you must set SOURCE_DATE_EPOCH and re-run.
          Tip: set GEM_CHECKSUMS_ASSUME_YES=true to proceed non-interactively (still requires SOURCE_DATE_EPOCH).
        PROMPT
        warn(prompt_msg)
        # Continue to enforce SOURCE_DATE_EPOCH below; if not set, this will raise.
      end

      build_time = ENV.fetch("SOURCE_DATE_EPOCH", "")
      build_time_missing = !(build_time =~ /\d{10,}/)

      if build_time_missing
        warn(BUILD_TIME_WARNING)
        raise Error, BUILD_TIME_ERROR_MESSAGE
      end
    end

    gem_path_parts =
      case RUNNING_AS
      when "rake", "gem_checksums"
        first_arg = ARGV.first
        first_arg.respond_to?(:split) ? first_arg.split("/") : []
      else # e.g. "rspec"
        []
      end

    if gem_path_parts.any?
      gem_name = gem_path_parts.last
      gem_pkg = File.join(gem_path_parts)
      puts "Looking for: #{gem_pkg.inspect}"
      gems = Dir[gem_pkg]
      raise Error, "Unable to find gem #{gem_pkg}" if gems.empty?

      puts "Found: #{gems.inspect}"
    else
      gem_pkgs = File.join(PACKAGE_DIR, "*.gem")
      puts "Looking for: #{gem_pkgs.inspect}"
      gems = Dir[gem_pkgs]
      raise Error, "Unable to find gems #{gem_pkgs}" if gems.empty?

      # Sort by newest last
      # [ "my_gem-2.3.9.gem", "my_gem-2.3.11.pre.alpha.4.gem", "my_gem-2.3.15.gem", ... ]
      gems.sort_by! { |gem| Gem::Version.new(gem[VERSION_REGEX]) }
      gem_pkg = gems.last
      gem_path_parts = gem_pkg.split("/")
      gem_name = gem_path_parts.last
      puts "Found: #{gems.length} gems; latest is #{gem_name}"
    end

    pkg_bits = File.read(gem_pkg)

    # SHA-512 digest is 8 64-bit words
    digest512_64bit = Digest::SHA512.new.hexdigest(pkg_bits)
    digest512_64bit_path = "#{CHECKSUMS_DIR}/#{gem_name}.sha512"
    Dir.mkdir(CHECKSUMS_DIR) unless Dir.exist?(CHECKSUMS_DIR)
    File.write(digest512_64bit_path, digest512_64bit)

    # SHA-256 digest is 8 32-bit words
    digest256_32bit = Digest::SHA256.new.hexdigest(pkg_bits)
    digest256_32bit_path = "#{CHECKSUMS_DIR}/#{gem_name}.sha256"
    File.write(digest256_32bit_path, digest256_32bit)

    version = gem_name[VERSION_REGEX]

    git_cmd = <<~GIT_MSG.rstrip
      git add #{CHECKSUMS_DIR}/* && \
      git commit #{git_dry_run_flag} -m "🔒️ Checksums for v#{version}"
    GIT_MSG

    if git_dry_run_flag
      git_cmd += <<~CLEANUP_MSG
         && \
        echo "Cleaning up in dry run mode" && \
        git reset #{digest512_64bit_path} && \
        git reset #{digest256_32bit_path} && \
        rm -f #{digest512_64bit_path} && \
        rm -f #{digest256_32bit_path}
      CLEANUP_MSG
    end

    puts <<~RESULTS
      [ GEM: #{gem_name} ]
      [ VERSION: #{version} ]
      [ GEM PKG LOCATION: #{gem_pkg} ]
      [ CHECKSUM SHA-256: #{digest256_32bit} ]
      [ CHECKSUM SHA-512: #{digest512_64bit} ]
      [ CHECKSUM SHA-256 PATH: #{digest256_32bit_path} ]
      [ CHECKSUM SHA-512 PATH: #{digest512_64bit_path} ]
      
      ... Running ...
      
      #{git_cmd}
    RESULTS

    if git_dry_run_flag
      %x{#{git_cmd}}
    else
      # `exec` will replace the current process with the git process, and exit.
      # Within the generate method, Ruby code placed after the `exec` *will not be run*:
      #   See: https://www.akshaykhot.com/call-shell-commands-in-ruby
      # But we can't exit the process when testing from RSpec,
      #   since that would exit the parent RSpec process
      exec(git_cmd)
    end
  end
  module_function :generate
end

GemChecksums::Version.class_eval do
  extend VersionGem::Basic
end

GemChecksums.install_tasks if GemChecksums::RUNNING_AS == "rake"
