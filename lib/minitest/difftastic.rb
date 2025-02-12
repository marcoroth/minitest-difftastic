# frozen_string_literal: true

require "difftastic"

require "minitest/difftastic/version"
require "minitest/difftastic/config"

module Minitest::Difftastic
  def self.configure
    yield Config
  end

  def self.default_differ
    ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      width: ::Minitest::Difftastic::Config.width,
      syntax_highlight: :off,
      left_label: "Expected",
      right_label: "Actual"
    )
  end

  def self.string_differ
    ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      width: ::Minitest::Difftastic::Config.width,
      syntax_highlight: :off,
      left_label: "Expected (String)",
      right_label: "Actual (String)"
    )
  end
end
