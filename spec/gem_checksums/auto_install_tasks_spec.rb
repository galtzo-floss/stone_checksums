# frozen_string_literal: true

require "rake"
require "anonymous_loader"

RSpec.describe "gem_checksums rake auto-install" do
  it "installs tasks automatically when loaded as rake" do
    previous_program_name = $PROGRAM_NAME.dup
    previous_verbose = $VERBOSE
    begin
      $PROGRAM_NAME = "rake"
      $VERBOSE = nil
      Rake.application = Rake::Application.new

      # `load`ing a path that Coverage is already tracking resets that file's
      # counters, and SimpleCov only reads the live counters when the process
      # exits, so re-loading the library here would erase coverage recorded by
      # other specs sharing this worker. AnonymousLoader re-executes the source
      # with `module_eval` at the same path instead, into a namespace that is
      # thrown away.
      namespace = AnonymousLoader.load(
        files: "lib/gem_checksums.rb",
        root: File.expand_path("../..", __dir__)
      )

      expect(namespace::GemChecksums::RUNNING_AS).to eq("rake")
      expect(Rake.application.options.rakelib).to include(a_string_matching(%r{gem_checksums/rakelib}))
    ensure
      $PROGRAM_NAME = previous_program_name
      $VERBOSE = previous_verbose
    end
  end
end
