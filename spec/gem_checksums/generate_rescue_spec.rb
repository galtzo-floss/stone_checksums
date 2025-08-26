# rubocop:disable RSpec/SpecFilePathFormat
RSpec.describe GemChecksums, :check_output do
  include_context "with stubbed env"

  it "covers the bundler_ver rescue path in ::generate without side effects" do
    begin
      # Arrange environment and constants
      stub_const("GemChecksums::CHECKSUMS_DIR", "spec/tmp/banana_checksums")
      stub_const("GemChecksums::PACKAGE_DIR", "spec/support/fixtures")
      stub_const("GemChecksums::RUNNING_AS", "gem_checksums")

      # Make ARGV look like CLI usage
      original_argv = ARGV.dup
      ARGV[0] = "spec/support/fixtures/gem_checksums-1.0.0.gem"

      # Ensure we don't error out on missing epoch and don't exec
      stub_env("GEM_CHECKSUMS_ASSUME_YES" => "true", "SOURCE_DATE_EPOCH" => "1234567890")

      # Stub filesystem and command execution
      allow(File).to receive(:read).and_return("bits")
      allow(Dir).to receive(:mkdir) # checksums dir may already exist
      allow(File).to receive(:write)
      allow(Kernel).to receive(:exec) # should not be called when git_dry_run true, but guard anyway
      allow(Kernel).to receive(:`).and_return("")

      # Act: run generate in dry run mode to avoid exec
      described_class.generate(git_dry_run: true)

      # Expectations to satisfy RuboCop RSpec cops
      expect(File).to have_received(:write).at_least(:once)
    ensure
      # Cleanup ARGV
      ARGV.replace(original_argv)
    end
  end
end
# rubocop:enable RSpec/SpecFilePathFormat
