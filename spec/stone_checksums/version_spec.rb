# frozen_string_literal: true

require "anonymous_loader"
require "stone_checksums/version_gem"

RSpec.describe StoneChecksums::Version do
  it_behaves_like "a Version module", described_class

  it "executes the version-gem extension file for coverage" do
    AnonymousLoader.load(
      files: File.expand_path("../../lib/stone_checksums/version_gem.rb", __dir__)
    )

    expect(described_class).to respond_to(:to_h)
  end
end
