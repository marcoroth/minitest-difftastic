# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "readline"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

Rake::TestTask.new(:examples) do |t|
  t.libs << "examples"
  t.libs << "lib"
  t.test_files = FileList["examples/**/assert_*.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]

def ask(prompt = "")
  Readline.readline("=== #{prompt}? (y/N) ", true).squeeze(" ").strip == "y"
end

namespace "snapshots" do
  snapshots_directory = Pathname.new("examples/snapshots")

  desc "Verify the Examples against the recorded snapshots in #{snapshots_directory}/"
  task :verify do
    ENV["VERIFY_SNAPSHOTS"] = "true"

    Rake::Task["examples"].invoke
  end

  desc "Update the Example snapshots based on the current run to #{snapshots_directory}/"
  task :update do
    ENV["VERIFY_SNAPSHOTS"] = "true"
    ENV["SAVE_SNAPSHOTS"] = "true"

    Rake::Task["snapshots:delete"].invoke
    Rake::Task["examples"].invoke
  end

  desc "Delete all recorded snapshots in #{snapshots_directory}/"
  task :delete do
    if snapshots_directory.exist?
      FileUtils.rm_rf(snapshots_directory) if ask("Are you sure you want to delete the folder: #{snapshots_directory}")
    else
      puts "#{snapshots_directory} doesn't exist"
    end
  end

  desc "Print and show all recorded snapshots in #{snapshots_directory}/"
  task :show do
    Dir["examples/snapshots/**/*.txt"].each do |file|
      content = File.read(file)

      puts "==== SNAPSHOT: #{file.gsub("examples/snapshots/", "")} ===="
      puts content
      puts
      puts
    end
  end
end
