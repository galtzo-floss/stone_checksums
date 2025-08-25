# This is a shim to make ease the pain of migrating from
#   the GemChecksums namespace to the StoneChecksums namespace.
# RubyGems disallowed pushing a gem called `gem_checksums`, hence the name games.
require_relative "gem_checksums"

# this library's version
require_relative "stone_checksums/version"

module StoneChecksums
  class Error < ::GemChecksums::Error; end

  class << self
    def install_tasks
      ::GemChecksums.install_tasks
    end

    def generate(git_dry_run: false)
      ::GemChecksums.generate(git_dry_run: git_dry_run)
    end
  end
end

StoneChecksums::Version.class_eval do
  extend VersionGem::Basic
end
