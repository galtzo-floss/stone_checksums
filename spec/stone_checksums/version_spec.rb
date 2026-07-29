# frozen_string_literal: true

require "stone_checksums/version_gem"
require "anonymous_loader"

RSpec.describe StoneChecksums::Version do
  it_behaves_like "a Version module", described_class

  it "is greater than 1.0.0" do
    expect(Gem::Version.new(described_class) >= Gem::Version.new("1.0.0")).to be(true)
  end

  it "loads version files into an anonymous namespace for coverage" do
    namespace = AnonymousLoader.load(
      files: %w[
        lib/stone_checksums/version.rb
        lib/stone_checksums/version_gem.rb
      ],
      root: File.expand_path("../..", __dir__)
    )

    expect(namespace::StoneChecksums::Version::VERSION).to eq(described_class::VERSION)
    expect(namespace::StoneChecksums::Version.singleton_class).to be < VersionGem::Basic
  end
end
