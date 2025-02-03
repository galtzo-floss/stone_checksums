# frozen_string_literal: true

# External library dependencies
require "version_gem/ruby"

# RSpec Configs
require_relative "config/byebug"
require_relative "config/rspec/rspec_block_is_expected"
require_relative "config/rspec/rspec_stubbed_env"
require_relative "config/rspec/rspec_core"
require_relative "config/rspec/version_gem"

# Last thing before loading this gem is to set up code coverage
begin
  # This does not require "simplecov", but
  require "kettle-soup-cover"
  #   this next line has a side effect of running `.simplecov`
  require "simplecov" if Kettle::Soup::Cover::DO_COV
rescue LoadError
  nil
end

# This gem
require "gem_checksums"
