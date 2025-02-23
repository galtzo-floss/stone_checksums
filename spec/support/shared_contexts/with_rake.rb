# frozen_string_literal: true

# Inspired by: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
# This version doesn't require a Rails app!
require "rake"

RSpec.shared_context("with rake") do |task_base_name|
  let(:rake_app) { Rake::Application.new }
  let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
  let(:task_dir) { "lib/gem_checksums/rakelib" }
  let(:task_args) { [] }
  let(:invoke) { rake_task.invoke(*task_args) }
  let(:rakelib) { File.join(__dir__, "..", "..", "..", task_dir) }
  let(:rake_task) { Rake::Task[task_name] }

  include_context "with stubbed env"

  def loaded_files_excluding_current_rake_file(task_base_name)
    $".reject { |file| file == File.join(rakelib, "#{task_base_name}.rake").to_s }
  end

  before do
    Rake.application = rake_app
    Rake.application.rake_require(task_base_name, [rakelib], loaded_files_excluding_current_rake_file(task_base_name))
  end
end
