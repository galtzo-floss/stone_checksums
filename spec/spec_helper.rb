# frozen_string_literal: true

# External library dependencies
require "version_gem/ruby"

# RSpec Configs
require_relative "config/byebug"
require_relative "config/rspec/rspec_block_is_expected"
require_relative "config/rspec/rspec_pending_for"
require_relative "config/rspec/rspec_stubbed_env"
require_relative "config/rspec/rspec_core"
require_relative "config/rspec/version_gem"

# Support
require_relative "support/shared_contexts/with_rake"

# Last thing before loading this gem is to set up code coverage
begin
  # This does not require "simplecov", but
  require "kettle-soup-cover"
  #   this next line has a side effect of running `.simplecov`
  require "simplecov" if defined?(Kettle) && Kettle::Soup::Cover::DO_COV
rescue LoadError
  nil
end

# Set ENV variables to alter the defaults since we don't want to destroy this gem's actual checksums.
ENV["GEM_CHECKSUMS_GIT_DRY_RUN"] = "true"
ENV["GEM_CHECKSUMS_CHECKSUMS_DIR"] = "banana_checksums"
ENV["GEM_CHECKSUMS_PACKAGE_DIR"] = "avocado_packages"

# This gem
require "stone_checksums"

RSpec.configure do |config|
  config.before do
    # We must delete the package directory because the real gems built for release go there,
    #   which makes this spec flaky locally.
    # In order to delete it we must ensure it is empty first.
    pkg_dir = "pkg"
    Dir[File.join(pkg_dir, "*.gem")].each do |file|
      puts "Deleting old gem #{file} to normalize specs"
      File.delete(file)
    end
    # This will fail if the directory is still not empty.
    Dir.rmdir(pkg_dir) if Dir.exist?(pkg_dir)

    stub_const("GemChecksums::GIT_DRY_RUN_ENV", true)
  end
end
