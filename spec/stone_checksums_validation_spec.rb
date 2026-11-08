require "tmpdir"

RSpec.describe StoneChecksums do
  describe ".validate_sha256!" do
    around do |example|
      Dir.mktmpdir do |dir|
        @dir = dir
        example.run
      end
    end

    let(:gem_path) { File.join(@dir, "example-1.0.0.gem") }
    let(:checksum_path) { File.join(@dir, "example-1.0.0.gem.sha256") }

    before { File.binwrite(gem_path, "package\x00bytes") }

    it "accepts a matching checksum with a trailing newline" do
      File.write(checksum_path, "#{Digest::SHA256.file(gem_path).hexdigest}\n")
      expect(described_class.validate_sha256!(gem_path, checksums_dir: @dir)).to be true
    end

    it "rejects a changed package" do
      File.write(checksum_path, Digest::SHA256.hexdigest("different"))
      expect { described_class.validate_sha256!(gem_path, checksums_dir: @dir) }.to raise_error(GemChecksums::Error, /SHA256 mismatch/)
    end

    it "rejects a missing checksum" do
      expect { described_class.validate_sha256!(gem_path, checksums_dir: @dir) }.to raise_error(GemChecksums::Error, /Expected checksum file not found/)
    end

    it "rejects a missing package" do
      File.delete(gem_path)
      expect { described_class.validate_sha256!(gem_path, checksums_dir: @dir) }.to raise_error(GemChecksums::Error, /Built gem not found/)
    end
  end
end
