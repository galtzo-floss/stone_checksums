# frozen_string_literal: true

require "rake"

RSpec.describe "gem_checksums rake auto-install" do
  it "installs tasks automatically when loaded as rake" do
    previous_program_name = $PROGRAM_NAME.dup
    previous_verbose = $VERBOSE
    begin
      $PROGRAM_NAME = "rake"
      $VERBOSE = nil
      Rake.application = Rake::Application.new

      load File.expand_path("../../lib/gem_checksums.rb", __dir__)

      expect(Rake.application.options.rakelib).to include(a_string_matching(%r{gem_checksums/rakelib}))
    ensure
      $PROGRAM_NAME = previous_program_name
      $VERBOSE = previous_verbose
    end
  end
end
