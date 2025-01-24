# frozen_string_literal: true

require "rake"

RSpec.describe GemChecksums do
  it "is a namespace" do
    expect(described_class).to be_a(Module)
  end

  describe "::generate" do
    subject(:install_tasks) { described_class.generate }

    it "raises an error" do
      block_is_expected.to raise_error(RuntimeError, /Unable to find gems/)
    end
  end

  describe "::install_tasks" do
    subject(:install_tasks) { described_class.install_tasks }

    it "loads vc_ruby/tasks.rb" do
      # The order is important, spec will fail if wrong order
      block_is_expected.to not_raise_error &
        change { Rake.application.options.rakelib }
          .to(include(%r{gem_checksums/rakelib}))
    end
  end
end
