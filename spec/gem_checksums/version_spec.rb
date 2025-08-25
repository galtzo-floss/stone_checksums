RSpec.describe GemChecksums::Version do
  it_behaves_like "a Version module", described_class

  it "is greater than 1.0.0" do
    expect(Gem::Version.new(described_class) >= Gem::Version.new("1.0.0")).to be(true)
  end

  it "ensures the version file is executed for coverage" do
    path = File.expand_path("../../lib/gem_checksums/version.rb", __dir__)
    # Re-execute the file to ensure SimpleCov tracks its lines in this run
    load path
    expect(GemChecksums::Version::VERSION).to be_a(String)
  end
end
