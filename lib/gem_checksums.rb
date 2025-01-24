# frozen_string_literal: true

# Std lib
require "digest/sha2"
require "fileutils"

# external gems
require "version_gem"

# this library's version
require_relative "gem_checksums/version"

module GemChecksums
  class Error < StandardError; end

  # Final clause of Regex `(?=\.gem)` is a positive lookahead assertion
  # See: https://learnbyexample.github.io/Ruby_Regexp/lookarounds.html#positive-lookarounds
  # Used to pattern match against a gem package name, which always ends with .gem.
  # The positive lookahead ensures it is present, and prevents it from being captured.
  VERSION_REGEX = /((\d+\.\d+\.\d+)([-.][0-9A-Za-z-]+)*)(?=\.gem)/
  RUNNING_AS = File.basename($PROGRAM_NAME)

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
  def generate
    puts "gem_checksums is RUNNING_AS: #{RUNNING_AS}"
    gem_path_parts =
      case RUNNING_AS
      when "rake", "gem_checksums"
        ARGV.first&.split("/")
      else # "rspec"
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
      raise "Unable to find gems #{gem_pkgs}" if gems.empty?

      # Sort by newest last
      # [ "my_gem-2.3.9.gem", "my_gem-2.3.11.pre.alpha.4.gem", "my_gem-2.3.15.gem", ... ]
      gems.sort_by! { |gem| Gem::Version.new(gem[VERSION_REGEX]) }
      gem_pkg = gems.last
      gem_path_parts = gem_pkg.split("/")
      gem_name = gem_path_parts.last
      puts "Found: #{gems.length} gems; latest is #{gem_name}"
    end

    checksum512 = Digest::SHA512.new.hexdigest(File.read(gem_pkg))
    checksum512_path = "checksums/#{gem_name}.sha512"
    File.write(checksum512_path, checksum512)

    checksum256 = Digest::SHA256.new.hexdigest(File.read(gem_pkg))
    checksum256_path = "checksums/#{gem_name}.sha256"
    File.write(checksum256_path, checksum256)

    version = gem_name[VERSION_REGEX]

    git_cmd = <<~GIT_MSG
      git add checksums/* && \
      git commit -m "🔒️ Checksums for v#{version}"
    GIT_MSG

    puts <<~RESULTS
      [ GEM: #{gem_name} ]
      [ VERSION: #{version} ]
      [ GEM PKG LOCATION: #{gem_pkg} ]
      [ CHECKSUM SHA-256: #{checksum256} ]
      [ CHECKSUM SHA-512: #{checksum512} ]
      [ CHECKSUM SHA-256 PATH: #{checksum256_path} ]
      [ CHECKSUM SHA-512 PATH: #{checksum512_path} ]

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
