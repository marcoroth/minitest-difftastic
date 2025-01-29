# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_assert_nil assert_nil

  def assert_nil(obj, msg = nil)
    differ = ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      syntax_highlight: :off,
      left_label: "Expected",
      right_label: "Actual"
    )

    msg ||= differ.diff_objects(nil, obj)

    minitest_assert_nil(obj, msg)
  rescue => e
    minitest_assert_nil(obj, msg)
  end
end
