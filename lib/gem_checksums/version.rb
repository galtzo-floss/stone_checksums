# frozen_string_literal: true

require_relative "../stone_checksums/version"

# Semantic version for the GemChecksums namespace
module GemChecksums
  # Version-related constants for GemChecksums
  module Version
    # Current gem version (delegated to StoneChecksums)
    # @return [String]
    VERSION = ::StoneChecksums::Version::VERSION
  end
end
