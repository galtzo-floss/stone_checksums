# frozen_string_literal: true

require "rake"

RSpec.describe GemChecksums do
  it "is a namespace" do
    expect(described_class).to be_a(Module)
  end

  describe "::generate" do
    subject(:generate) { described_class.generate }

    include_context "with stubbed env"

    context "with SOURCE_DATE_EPOCH set" do
      before do
        stub_env("SOURCE_DATE_EPOCH" => "1738472935")
      end

      it "raises an error" do
        block_is_expected.to raise_error(GemChecksums::Error, "Unable to find gems pkg/*.gem")
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

  describe "::install_tasks" do
    subject(:install_tasks) { described_class.install_tasks }

    before do
      Rake.application = Rake::Application.new
    end

    it "loads gem_checksums/tasks.rb" do
      # The order is important, spec will fail if wrong order
      block_is_expected.to not_raise_error &
        change { Rake.application.options.rakelib }
          .to(include(%r{gem_checksums/rakelib}))
    end
  end
end
