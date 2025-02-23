# frozen_string_literal: true

require "rake"

RSpec.describe "rake build:checksums" do # rubocop:disable RSpec/DescribeClass
  subject(:build_checksums) { invoke }

  include_context "with rake", "gem_checksums"

  context "with SOURCE_DATE_EPOCH set" do
    before do
      stub_env("SOURCE_DATE_EPOCH" => "1738472935")
    end

    context "when running as Rake without arguments" do
      before do
        stub_const("GemChecksums::RUNNING_AS", "rake")
        stub_const("ARGV", [])
      end

      it "raises an error" do
        block_is_expected.to raise_error(GemChecksums::Error, "Unable to find gems pkg/*.gem")
      end

      context "when good package directory" do
        let(:pkg_dir) { "spec/support/fixtures" }

        before do
          stub_const("GemChecksums::RUNNING_AS", "rake")
          stub_const("GemChecksums::PACKAGE_DIR", pkg_dir)
        end

        it "does not raise an error" do
          block_is_expected.to not_raise_error
        end

        context "with output" do
          it "prints information" do
            block_is_expected.to output(<<-CHECKSUMS_OUTPUT).to_stdout
Looking for: "spec/support/fixtures/*.gem"
Found: 1 gems; latest is gem_checksums-1.0.0.gem
[ GEM: gem_checksums-1.0.0.gem ]
[ VERSION: 1.0.0 ]
[ GEM PKG LOCATION: spec/support/fixtures/gem_checksums-1.0.0.gem ]
[ CHECKSUM SHA-256: 8e35e0a7cae7fab47c0b7e3d3e81d38294151138bcfcfe8d4aa2e971ff302339 ]
[ CHECKSUM SHA-512: 8b18f8422f22a5a3b301deeaeb8b4e669dfc8033a63c1b5fbfc787af59f60e9df7f920ae2c48ede27ef7d09f0b025f63fc2474a842d54d8f148b266eac4bfa94 ]
[ CHECKSUM SHA-256 PATH: checksums/gem_checksums-1.0.0.gem.sha256 ]
[ CHECKSUM SHA-512 PATH: checksums/gem_checksums-1.0.0.gem.sha512 ]

... Running ...

git add checksums/* && git commit --dry-run -m "🔒️ Checksums for v1.0.0" && echo "Cleaning up in dry run mode" && git reset checksums/gem_checksums-1.0.0.gem.sha512 && git reset checksums/gem_checksums-1.0.0.gem.sha256 && rm -f checksums/gem_checksums-1.0.0.gem.sha512 && rm -f checksums/gem_checksums-1.0.0.gem.sha256

            CHECKSUMS_OUTPUT
          end
        end
      end
    end

    context "when running as Rake with good arguments" do
      let(:gem_fixture) { "spec/support/fixtures/gem_checksums-1.0.0.gem" }

      before do
        stub_const("GemChecksums::RUNNING_AS", "rake")
        stub_const("ARGV", [gem_fixture])
      end

      it "does not raise an error" do
        block_is_expected.to not_raise_error
      end

      context "with output" do
        it "prints information" do
          block_is_expected.to output(<<-CHECKSUMS_OUTPUT).to_stdout
Looking for: "spec/support/fixtures/gem_checksums-1.0.0.gem"
Found: ["spec/support/fixtures/gem_checksums-1.0.0.gem"]
[ GEM: gem_checksums-1.0.0.gem ]
[ VERSION: 1.0.0 ]
[ GEM PKG LOCATION: spec/support/fixtures/gem_checksums-1.0.0.gem ]
[ CHECKSUM SHA-256: 8e35e0a7cae7fab47c0b7e3d3e81d38294151138bcfcfe8d4aa2e971ff302339 ]
[ CHECKSUM SHA-512: 8b18f8422f22a5a3b301deeaeb8b4e669dfc8033a63c1b5fbfc787af59f60e9df7f920ae2c48ede27ef7d09f0b025f63fc2474a842d54d8f148b266eac4bfa94 ]
[ CHECKSUM SHA-256 PATH: checksums/gem_checksums-1.0.0.gem.sha256 ]
[ CHECKSUM SHA-512 PATH: checksums/gem_checksums-1.0.0.gem.sha512 ]

... Running ...

git add checksums/* && git commit --dry-run -m "🔒️ Checksums for v1.0.0" && echo "Cleaning up in dry run mode" && git reset checksums/gem_checksums-1.0.0.gem.sha512 && git reset checksums/gem_checksums-1.0.0.gem.sha256 && rm -f checksums/gem_checksums-1.0.0.gem.sha512 && rm -f checksums/gem_checksums-1.0.0.gem.sha256

          CHECKSUMS_OUTPUT
        end
      end

      context "with no checksums directory" do
        let(:checksums_dir) { "snooty_checksums" }

        before do
          stub_const("GemChecksums::CHECKSUMS_DIR", checksums_dir)
          Dir.rmdir(checksums_dir) if Dir.exist?(checksums_dir)
        end

        after do
          Dir.rmdir(checksums_dir) if Dir.exist?(checksums_dir)
        end

        it "creates the checksums directory" do
          build_checksums
          expect(Dir.exist?(checksums_dir)).to be true
        end
      end
    end

    context "when running as Rake with bad arguments" do
      let(:gem_fixture) { "spec/support/fixtures/unreal-1.0.0.gem" }

      before do
        stub_const("GemChecksums::RUNNING_AS", "rake")
        stub_const("ARGV", [gem_fixture])
      end

      it "raises an error" do
        block_is_expected.to raise_error(GemChecksums::Error, "Unable to find gem #{gem_fixture}")
      end
    end
  end

  context "without SOURCE_DATE_EPOCH set" do
    before do
      stub_env("SOURCE_DATE_EPOCH" => "")
    end

    it "raises an error" do
      block_is_expected.to raise_error(GemChecksums::Error, "Environment variable SOURCE_DATE_EPOCH must be set. You'll need to rebuild the gem. See gem_checksums/README.md")
    end
  end
end
