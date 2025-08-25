# rubocop:disable RSpec/SpecFilePathFormat
RSpec.describe GemChecksums do
  include_context "with stubbed env"

  describe "::generate when Bundler < 2.7 and SOURCE_DATE_EPOCH is missing" do
    before do
      # Ensure SOURCE_DATE_EPOCH is missing
      stub_env("SOURCE_DATE_EPOCH" => nil)

      # Simulate Bundler < 2.7.0 so the epoch is required
      if Object.const_defined?(:Bundler)
        stub_const("Bundler::VERSION", "2.6.9")
      end
    end

    it "warns with preferred upgrade guidance" do
      expect do
        begin
          described_class.generate(git_dry_run: true)
        rescue GemChecksums::Error
          # swallow for output assertion
        end
      end.to output(a_string_including("Upgrade to Bundler >= 2.7.0")).to_stderr
    end

    it "raises the standard error when epoch is missing" do
      expect do
        described_class.generate(git_dry_run: true)
      end.to raise_error(GemChecksums::Error, GemChecksums::BUILD_TIME_ERROR_MESSAGE)
    end
  end
end
# rubocop:enable RSpec/SpecFilePathFormat
