# frozen_string_literal: true

require "fileutils"

class String
  def under_score
    gsub("::", "/")
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .downcase
  end
end

Minitest::Difftastic.configure do |config|
  # we set this to match the terminal width of the GitHub Action Runner
  config.width = 80
end

module DifftasticSnapshotHelper
  def run
    @did_raise = false

    begin
      super
    rescue Minitest::Assertion => original_exception
      @did_raise = true

      save_failures_to_snapshot(original_exception) if ENV["SAVE_SNAPSHOTS"]

      begin
        assert_snapshot_matches(original_exception)
      rescue Minitest::Assertion => e
        failures << e
      end
    end

    begin
      assert @did_raise, "Example doesn't have a failing assertion: #{name}"
    rescue Minitest::Assertion => e
      failures << e
    end

    Minitest::Result.from self
  end

  private

  def save_failures_to_snapshot(exception)
    puts "Updating Snapshot for #{name} at: #{snapshot_file}"

    FileUtils.mkdir_p(snapshot_file.dirname)
    snapshot_file.write(exception.message)
  end

  def assert_snapshot_matches(exception)
    assert snapshot_file.exist?, "Expected snapshot file to exist: #{snapshot_file.to_path}"

    expected_output = snapshot_file.read
    actual_output = exception.message

    message = <<~MESSAGE
      Snapshot mismatch for #{name}\e[0m

      \e[91;1m======== [ Expected Snapshot (#{name}) ] ========\e[0m
      #{expected_output}
      \e[92;1m======== [  Actual Snapshot (#{name})  ] ========\e[0m
      #{actual_output}
      ========
    MESSAGE

    assert expected_output == actual_output, message
  end

  def snapshot_file
    ruby_version = RUBY_VERSION.split(".")[..1].join("-")
    test_class_name = self.class.name.under_score

    @snapshot_file ||= Pathname.new("examples/snapshots/ruby-#{ruby_version}/#{test_class_name}/#{name}.txt")
  end
end

class Minitest::Test
  PASSTHROUGH_EXCEPTIONS.push(Minitest::Assertion)

  prepend DifftasticSnapshotHelper
end
