# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers

# Inspired by: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
# This version doesn't require a Rails app!
require "rake"

# Runs a Rake DSL file for the current process, exactly once via `load`.
#
# Every `with rake` example swaps in a fresh Rake::Application, so the file that
# defines the tasks has to run again for each example. Re-running it with `load`
# — what `Rake#rake_require` does — resets that path's Ruby Coverage counters, and
# SimpleCov only reads the live counters when the process exits, so in a shared
# parallel worker the last load wins: an example that loads the file but never
# invokes the task (a pending example, for instance) leaves the task body reported
# as never covered. `load` records coverage, so it runs once per process; later
# examples re-run the same source with `eval` at the same path and line numbers,
# which defines the tasks on the fresh application without clearing counters.
module RakeFileLoader
  # @api private
  LOADED_FILES = {} # rubocop:disable Style/MutableConstant

  def self.load(rake_file)
    return eval(File.read(rake_file), TOPLEVEL_BINDING, rake_file, 1) if LOADED_FILES[rake_file] # rubocop:disable Security/Eval

    LOADED_FILES[rake_file] = true
    Kernel.load(rake_file)
  end
end

RSpec.shared_context("with rake") do |task_base_name|
  let(:rake_app) { Rake::Application.new }
  let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
  let(:task_dir) { "lib/gem_checksums/rakelib" }
  let(:task_args) { [] }
  let(:invoke) { rake_task.invoke(*task_args) }
  let(:rakelib) { File.join(__dir__, "..", "..", "..", task_dir) }
  let(:rake_task) do
    RakeFileLoader.load(File.expand_path(File.join(rakelib, "#{task_base_name}.rake")))
    Rake::Task[task_name]
  end

  include_context "with stubbed env"

  before do
    Rake.application = rake_app
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
