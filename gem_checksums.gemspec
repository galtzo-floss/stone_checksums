# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
# Kernel.load because load is overloaded in RubyGems during gemspec evaluation
Kernel.load("lib/gem_checksums/version.rb")
gem_version = GemChecksums::Version::VERSION
GemChecksums::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "gem_checksums"
  spec.version = gem_version
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  if $PROGRAM_NAME.end_with?("gem") && ARGV == ["build", __FILE__]
    spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
  end

  spec.summary = "Generate both SHA256 & SHA512 checksums of RubyGem libraries"
  spec.description = "Generate both SHA256 & SHA512 checksums into the checksums directory, and git commit them"
  spec.homepage = "https://github.com/pboling/gem_checksums"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.2.0"

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
    "lib/gem_checksums/rakelib/*.rake",
    "sig/**/*.rbs",
  ]
  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "README.md",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]

  # bin/ is scripts, in any available language, for development of this specific gem
  # exe/ is for ruby scripts that will ship with this gem to be used by other tools
  spec.bindir = "exe"
  spec.executables = %w[
    gem_checksums
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency("version_gem", ">= 1.1.5", "< 3")

  # Tests
  spec.add_development_dependency("rspec", "~> 3.13")                         # ruby >= 0
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0")        # ruby >= 1.8.7
  spec.add_development_dependency("rspec-pending_for", "~> 0.1", ">= 0.1.16") # ruby >= 1.8.7
  spec.add_development_dependency("rspec-stubbed_env", "~> 1.0", ">= 1.0.1")  # Ruby >= 1.8.7

  # Development Tasks
  spec.add_development_dependency("rake", "~> 13.0")                          # ruby >= 2.2

  # Linting - rubocop-lts v8 is a rubocop wrapper for Ruby >= 2.2,
  #   and should only be bumped when dropping old Ruby support
  # NOTE: it can only be installed on, and run on Ruby >= 2.7, so we add the dependency in the Gemfile.
  # see: https://rubocop-lts.gitlab.io
  # spec.add_development_dependency 'rubocop-lts', ['~> 8.1', '>= 8.1.1']
end
