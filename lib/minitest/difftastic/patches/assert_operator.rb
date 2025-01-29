# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_assert_operator assert_operator

  def assert_operator(object1, operator, object2 = UNDEFINED, msg = nil)
    differ = ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      syntax_highlight: :off,
      left_label: "Expected",
      right_label: "to be #{operator}"
    )

    message = differ.diff_objects(object1, object2)

    minitest_assert_operator(object1, operator, object2, message)
  rescue StandardError
    minitest_assert_operator(object1, operator, object2, msg)
  end
end
