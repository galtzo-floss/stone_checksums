# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/gem_checksums/version.rb"
gem_version = GemChecksums::Version::VERSION
GemChecksums::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "gem_checksums"
  spec.version = gem_version
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.summary = "Generate both SHA256 & SHA512 checksums of RubyGem libraries"
  spec.description = spec.summary
  spec.homepage = "https://github.com/pboling/gem_checksums"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["homepage_uri"] = "https://railsbling.com/tags/#{spec.name}/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    "sig/**/*.rbs",
    "lib/gem_checksums/rakelib/*.rake",
    # Files (alphabetical)
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
  ]

  # bin/ is scripts, in any available language, for development of this specific gem
  # exe/ is for ruby scripts that will ship with this gem to be used by other tools
  spec.bindir = "exe"
  spec.executables = %w[
    gem_checksums
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency("version_gem", ">= 1.1.4", "< 3")

  ### Documentation
  spec.add_development_dependency("github-markup", "~> 5.0", ">= 5.0.1")
  spec.add_development_dependency("rdoc", "~> 6.11")
  spec.add_development_dependency("redcarpet", "~> 3.6")
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.37")
  spec.add_development_dependency("yard-junk", "~> 0.0", ">= 0.0.10")

  ###  Linting
  spec.add_development_dependency("reek", "~> 6.4")
  spec.add_development_dependency("rubocop-lts", "~> 18.2", ">= 18.2.1")
  spec.add_development_dependency("rubocop-packaging", "~> 0.5", ">= 0.5.2")
  spec.add_development_dependency("rubocop-rspec", "~> 3.4")
  spec.add_development_dependency("standard", "~> 1.44")

  ### Testing
  spec.add_development_dependency("rake", "~> 13.2", ">= 13.2.1")
  spec.add_development_dependency("rspec", "~> 3.13")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.6")

  ### Coverage
  spec.add_development_dependency("kettle-soup-cover", "~> 1.0", ">= 1.0.4")
end
