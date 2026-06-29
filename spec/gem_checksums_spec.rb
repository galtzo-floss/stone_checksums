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

    context "when the selected built gem does not match the current gemspec" do
      before do
        project_spec = instance_double(Gem::Specification, name: "gem_checksums", version: Gem::Version.new("0.9.0"))
        allow(described_class).to receive(:current_project_spec).and_return(project_spec)
      end

      it "fails closed with a version mismatch error" do
        expect { described_class.validate_project_package!("spec/support/fixtures/gem_checksums-1.0.0.gem") }.to raise_error(
          GemChecksums::Error,
          /Current gemspec resolves to gem_checksums 0\.9\.0, but selected package is gem_checksums 1\.0\.0/
        )
      end
    end

    context "when stale package artifacts exist for newer versions" do
      before do
        project_spec = instance_double(Gem::Specification, name: "rubocop-lts", version: Gem::Version.new("0.3.1"))
        allow(described_class).to receive(:current_project_spec).and_return(project_spec)
      end

      it "prefers the package matching the current gemspec" do
        packages = [
          "pkg/rubocop-lts-0.3.1.gem",
          "pkg/rubocop-lts-24.2.0.gem"
        ]

        expect(described_class.preferred_project_package(packages)).to eq("pkg/rubocop-lts-0.3.1.gem")
      end

      it "returns nil when no package matches the current gemspec" do
        packages = [
          "pkg/rubocop-lts-0.3.0.gem",
          "pkg/rubocop-lts-24.2.0.gem"
        ]

        expect(described_class.preferred_project_package(packages)).to be_nil
      end
    end

    context "when there is no current project gemspec" do
      before do
        allow(described_class).to receive(:current_project_spec).and_return(nil)
      end

      it "does not prefer a package" do
        expect(described_class.preferred_project_package(["pkg/rubocop-lts-0.3.1.gem"])).to be_nil
      end

      it "skips package validation" do
        expect(described_class.validate_project_package!("pkg/rubocop-lts-0.3.1.gem")).to be_nil
      end
    end

    describe "::current_project_spec" do
      it "returns nil when there is not exactly one gemspec" do
        allow(Dir).to receive(:[]).with("*.gemspec").and_return(%w[one.gemspec two.gemspec])
        expect(described_class.current_project_spec).to be_nil
      end
    end

    describe "::validate_package_against_project?" do
      let(:project_spec) { instance_double(Gem::Specification, name: "rubocop-lts") }

      it "validates default pkg packages" do
        stub_const("GemChecksums::PACKAGE_DIR", "pkg")
        expect(described_class.validate_package_against_project?("pkg/other-1.0.0.gem", project_spec)).to be true
      end

      it "validates matching packages outside the default pkg directory" do
        stub_const("GemChecksums::PACKAGE_DIR", "fixtures")
        expect(described_class.validate_package_against_project?("fixtures/rubocop-lts-1.0.0.gem", project_spec)).to be true
      end

      it "skips non-matching packages outside the default pkg directory" do
        stub_const("GemChecksums::PACKAGE_DIR", "fixtures")
        expect(described_class.validate_package_against_project?("fixtures/other-1.0.0.gem", project_spec)).to be false
      end
    end

    context "when the selected built gem matches the current gemspec" do
      before do
        project_spec = instance_double(Gem::Specification, name: "rubocop-lts", version: Gem::Version.new("0.3.1"))
        package_spec = instance_double(Gem::Specification, name: "rubocop-lts", version: Gem::Version.new("0.3.1"))
        package = instance_double(Gem::Package, spec: package_spec)
        allow(described_class).to receive(:current_project_spec).and_return(project_spec)
        allow(Gem::Package).to receive(:new).with("pkg/rubocop-lts-0.3.1.gem").and_return(package)
      end

      it "passes package validation" do
        expect(described_class.validate_project_package!("pkg/rubocop-lts-0.3.1.gem")).to be_nil
      end
    end

    context "when a non-project package is selected outside the default pkg directory" do
      before do
        project_spec = instance_double(Gem::Specification, name: "rubocop-lts", version: Gem::Version.new("0.3.1"))
        allow(described_class).to receive(:current_project_spec).and_return(project_spec)
      end

      it "skips package validation" do
        stub_const("GemChecksums::PACKAGE_DIR", "fixtures")
        expect(described_class.validate_project_package!("fixtures/other-1.0.0.gem")).to be_nil
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
