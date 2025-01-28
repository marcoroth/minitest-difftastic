# frozen_string_literal: true

require "difftastic"

require "minitest/difftastic/version"

module Minitest::Difftastic
  DEFAULT_DIFFER = ::Difftastic::Differ.new(
    color: :always,
    tab_width: 2,
    syntax_highlight: :off,
    left_label: "Expected",
    right_label: "Actual"
  )
end
