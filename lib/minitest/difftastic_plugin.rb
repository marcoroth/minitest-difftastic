# frozen_string_literal: true

require "difftastic"

# TODO: use refinements
module Minitest
  module Assertions
    DIFFER = ::Difftastic::Differ.new(
      color: :always,
      tab_width: TAB_WIDTH,
      syntax_highlight: :off,
      left_label: "Expected",
      right_label: "Actual"
    )

    alias diff_original diff

    def diff(exp, act)
      DIFFER.diff_objects(exp, act)
    rescue StandardError => e
      puts "Minitest::DiffTastic error: #{e.inspect} (#{e.backtrace[0]})"
      diff_original(exp, act)
    end
  end
end
