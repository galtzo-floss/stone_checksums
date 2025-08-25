# StoneChecksums is the canonical namespace for this gem.
#
# This module is a thin shim that delegates to the historical
# GemChecksums namespace for all behavior. The GemChecksums namespace
# will continue to work for backwards compatibility, but new code
# should refer to StoneChecksums to match the gem name.
#
# RubyGems does not allow publishing a gem named `gem_checksums`,
# hence the updated namespace and gem name.
require_relative "gem_checksums"

# This library's version
require_relative "stone_checksums/version"

# Primary namespace of this library (shim over GemChecksums)
#
# @example Load Rake tasks provided by the gem
#   require "stone_checksums"
#   StoneChecksums.install_tasks
#
# @example Generate checksums for the newest built gem (dry run)
#   StoneChecksums.generate(git_dry_run: true)
module StoneChecksums
  # Error class used by this gem.
  #
  # All errors raised under this namespace are subclasses of
  # GemChecksums::Error for compatibility.
  class Error < ::GemChecksums::Error; end

  class << self
    # Load gem-provided Rake tasks into the current Rake application.
    #
    # This delegates to GemChecksums.install_tasks.
    #
    # @return [void]
    def install_tasks
      ::GemChecksums.install_tasks
    end

    # Generate SHA-256 and SHA-512 checksums for a built .gem and commit them.
    #
    # Behavior, options, and side effects are identical to
    # GemChecksums.generate; this method delegates directly to it.
    #
    # @param git_dry_run [Boolean] when true, perform a dry-run and do not leave files staged
    # @return [void]
    def generate(git_dry_run: false)
      ::GemChecksums.generate(git_dry_run: git_dry_run)
    end
  end
end

# Extend the Version module with helpers from version_gem
StoneChecksums::Version.class_eval do
  extend VersionGem::Basic
end
