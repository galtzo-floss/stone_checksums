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
  VERSION_REGEX = /((\d+\.\d+\.\d+)([-.][0-9A-Za-z-]+)*)(?=\.gem)/
  RUNNING_AS = File.basename($PROGRAM_NAME)
  BUILD_TIME_ERROR_MESSAGE = "Environment variable SOURCE_DATE_EPOCH must be set. You'll need to rebuild the gem. See gem_checksums/README.md"

  # Make this gem's rake tasks available in your Rakefile:
  #
  #   require "gem_checksums"
  #   GemChecksums.install_tasks
  #
  def install_tasks
    load("gem_checksums/tasks.rb")
  end
  module_function :install_tasks

  # Script, stolen from myself, from https://github.com/rubygems/guides/pull/325
  # NOTE: SOURCE_DATE_EPOCH must be set in your environment prior to building the gem.
  #       This ensures that the gem build, and the gem checksum will use the same timestamp,
  #       and thus will match the SHA-256 checksum generated for every gem on Rubygems.org.
  def generate
    build_time = ENV.fetch("SOURCE_DATE_EPOCH", "")
    build_time_missing = !(build_time =~ /\d{10,}/)

    if build_time_missing
      warn(
        <<~BUILD_TIME_WARNING,
          WARNING: Build time not provided via environment variable SOURCE_DATE_EPOCH.
                   To ensure consistent SHA-256 & SHA-512 checksums,
                   you must set this environment variable *before* building the gem.
          
          IMPORTANT: After setting the build time, you *must re-build the gem*, i.e. bundle exec rake build, or gem build.
          
          How to set the build time:

          In zsh shell:
            - export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH
            - If the echo above has no output, then it didn't work.
            - Note that you'll need the `zsh/datetime` module enabled.

          In fish shell:
            - set -x SOURCE_DATE_EPOCH (date +%s)
            - echo $SOURCE_DATE_EPOCH 

          In bash shell:
            - export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
      
        BUILD_TIME_WARNING
      )
      raise Error, BUILD_TIME_ERROR_MESSAGE
    end

    gem_path_parts =
      case RUNNING_AS
      when "rake", "gem_checksums"
        ARGV.first&.split("/")
      else # e.g. "rspec"
        []
      end

    if gem_path_parts&.any?
      gem_name = gem_path_parts.last
      gem_pkg = File.join(gem_path_parts)
      puts "Looking for: #{gem_pkg.inspect}"
      gems = Dir[gem_pkg]
      puts "Found: #{gems.inspect}"
    else
      gem_pkgs = File.join("pkg", "*.gem")
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
    digest512_64bit_path = "checksums/#{gem_name}.sha512"
    File.write(digest512_64bit_path, digest512_64bit)

    # SHA-256 digest is 8 32-bit words
    digest256_32bit = Digest::SHA256.new.hexdigest(pkg_bits)
    digest256_32bit_path = "checksums/#{gem_name}.sha256"
    File.write(digest256_32bit_path, digest256_32bit)

    version = gem_name[VERSION_REGEX]

    git_cmd = <<~GIT_MSG
      git add checksums/* && \
      git commit -m "🔒️ Checksums for v#{version}"
    GIT_MSG

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

    # This will replace the current process with the git process, and exit.
    # Within the generate method, Ruby code placed after the `exec` *will not be run*:
    #   See: https://www.akshaykhot.com/call-shell-commands-in-ruby
    exec(git_cmd)
  end
  module_function :generate
end

GemChecksums::Version.class_eval do
  extend VersionGem::Basic
end

GemChecksums.install_tasks if GemChecksums::RUNNING_AS == "rake"
