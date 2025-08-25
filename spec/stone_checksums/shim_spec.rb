# rubocop:disable RSpec/SpecFilePathFormat
RSpec.describe StoneChecksums do
  describe "::Error" do
    it "is a subclass of GemChecksums::Error" do
      expect(described_class::Error <= GemChecksums::Error).to be(true)
    end
  end

  describe "::Version" do
    it "matches GemChecksums::Version::VERSION" do
      expect(described_class::Version::VERSION).to eq(GemChecksums::Version::VERSION)
    end
  end

  describe "delegation" do
    it "delegates ::install_tasks to GemChecksums.install_tasks" do
      allow(GemChecksums).to receive(:install_tasks)
      described_class.install_tasks
      expect(GemChecksums).to have_received(:install_tasks).with(no_args)
    end

    it "delegates ::generate to GemChecksums.generate with args" do
      allow(GemChecksums).to receive(:generate)
      described_class.generate(git_dry_run: true)
      expect(GemChecksums).to have_received(:generate).with(git_dry_run: true)
    end

    it "delegates ::generate to GemChecksums.generate without args" do
      allow(GemChecksums).to receive(:generate)
      described_class.generate
      expect(GemChecksums).to have_received(:generate).with(git_dry_run: false)
    end
  end
end
# rubocop:enable RSpec/SpecFilePathFormat
