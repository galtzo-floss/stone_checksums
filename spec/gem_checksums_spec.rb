# frozen_string_literal: true

require "rake"

RSpec.describe GemChecksums do
  it "is a namespace" do
    expect(described_class).to be_a(Module)
  end

  describe "::generate" do
    subject(:generate) { described_class.generate }

    include_context "with stubbed env"

    it "prints a header with gem name and version", :check_output do
      stub_env("SOURCE_DATE_EPOCH" => "")
      stub_const("Bundler::VERSION", "2.7.0")
      expect { generate }.to output(/\[ stone_checksums #{Regexp.escape(StoneChecksums::Version::VERSION)} \]/o).to_stdout.and \
        raise_error(GemChecksums::Error, /Unable to find gems/)
    end

    context "with SOURCE_DATE_EPOCH set" do
      before do
        stub_env("SOURCE_DATE_EPOCH" => "1738472935")
      end

      it "raises an error" do
        block_is_expected.to raise_error(GemChecksums::Error, "Unable to find gems avocado_packages/*.gem")
      end
    end

    context "without SOURCE_DATE_EPOCH set and Bundler >= 2.7.0" do
      before do
        stub_env("SOURCE_DATE_EPOCH" => "")
        stub_const("Bundler::VERSION", "2.7.0")
      end

      it "does not check SOURCE_DATE_EPOCH and proceeds to search for gems" do
        block_is_expected.to raise_error(GemChecksums::Error, "Unable to find gems avocado_packages/*.gem")
      end
    end

    context "without SOURCE_DATE_EPOCH set and Bundler < 2.7.0" do
      before do
        stub_env("SOURCE_DATE_EPOCH" => "")
        stub_const("Bundler::VERSION", "2.6.9")
        stub_env("GEM_CHECKSUMS_ASSUME_YES" => "true")
      end

      it "enforces SOURCE_DATE_EPOCH and fails" do
        block_is_expected.to raise_error(GemChecksums::Error, "Environment variable SOURCE_DATE_EPOCH must be set. You'll need to rebuild the gem. See README.md of stone_checksums")
      end
    end

    context "when prompt is shown for old Bundler without proceeding", :check_output do
      before do
        stub_env("SOURCE_DATE_EPOCH" => "")
        stub_const("Bundler::VERSION", "2.6.9")
        # GEM_CHECKSUMS_ASSUME_YES not set => will print prompt/warning and then enforce
      end

      it "prints guidance and then fails" do
        expect { generate }.to output(/Detected Bundler 2.6.9.*older than 2.7.0/m).to_stderr.and \
          raise_error(GemChecksums::Error, /SOURCE_DATE_EPOCH must be set/)
      end
    end
  end

  context "when not dry-run and a built gem exists" do
    include_context "with stubbed env"

    let(:checksums_dir) { "dragon_checksums" }

    before do
      # Ensure environment picks non-dry-run branch
      stub_const("GemChecksums::GIT_DRY_RUN_ENV", false)
      stub_const("Bundler::VERSION", "2.7.0")
      stub_const("GemChecksums::PACKAGE_DIR", "spec/support/fixtures")
      stub_const("GemChecksums::CHECKSUMS_DIR", checksums_dir)
      if Dir.exist?(checksums_dir)
        Dir[File.join(checksums_dir, "*")].each { |f| File.delete(f) }
        Dir.rmdir(checksums_dir)
      end
    end

    after do
      # Clean up any files created during the run
      if Dir.exist?(checksums_dir)
        Dir[File.join(checksums_dir, "*")].each { |f| File.delete(f) }
        Dir.rmdir(checksums_dir)
      end
    end

    it "calls exec with a git commit command (no --dry-run)" do
      allow(described_class).to receive(:exec)
      described_class.generate(git_dry_run: false)
      expect(described_class).to have_received(:exec).with(a_string_including("git commit  -m \"🔒️ Checksums for v1.0.0\""))
    end
  end

  context "when Bundler::VERSION raises (rescue path)" do
    include_context "with stubbed env"

    before do
      stub_env("SOURCE_DATE_EPOCH" => "1738472935")
      # Simulate Bundler constant existing but VERSION access raising
      stub_const("Bundler::VERSION", nil) if defined?(Bundler::VERSION)
      allow(Bundler).to receive(:VERSION).and_raise(StandardError)
      stub_const("GemChecksums::RUNNING_AS", "rspec")
    end

    it "falls back to requires_epoch and continues (then fails to find gems)" do
      expect { described_class.generate }.to raise_error(GemChecksums::Error, /Unable to find gems/)
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
