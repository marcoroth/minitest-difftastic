# frozen_string_literal: true

require "difftastic"

# TODO: use refinements
module Minitest
  module Assertions
    MINIMUM_OFFSET = 29
    TAB_WIDTH = 2

    RED = "\e[91;1m"
    GREEN = "\e[92;1m"
    RESET = "\e[0m"

    DIFFER = ::Difftastic::Differ.new(
      color: :always,
      tab_width: TAB_WIDTH,
      syntax_highlight: :off
    )

    alias diff_original diff

    def diff(exp, act)
      diff = DIFFER.diff_objects(exp, act)
      offset = actual_text_offset(diff.split("\n").first)

      "\n#{RED}#{"Expected".ljust(offset)} #{GREEN}Actual#{RESET}\n#{diff}"
    rescue StandardError => e
      puts "Minitest::DiffTastic error: #{e.inspect} (#{e.backtrace[0]})"
      diff_original(exp, act)
    end

    private

    def strip_ansi_formatting(string)
      string.to_s.gsub(/\e\[[0-9;]*m/, "")
    end

    def actual_text_offset(line)
      stripped_line = strip_ansi_formatting(line)
      _lhs, rhs = stripped_line.split(/\s{#{TAB_WIDTH},}/, 2)

      offset = stripped_line.index("#{" " * TAB_WIDTH}#{rhs}") + TAB_WIDTH - 1

      [MINIMUM_OFFSET, offset].max
    end
  end
end
