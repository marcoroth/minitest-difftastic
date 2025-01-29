# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_assert_predicate assert_predicate

  def assert_predicate(object, predicate, msg = nil)
    pretty = Difftastic.pretty(object)

    expected = <<~ABC
      #{pretty}.#{predicate}

      # => true
    ABC

    actual = <<~ABC
      #{pretty}.#{predicate}

      # => false
    ABC

    differ = ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      syntax_highlight: :on,
      left_label: "Expected",
      right_label: "Actual",
      context: expected.lines.count
    )

    message = differ.diff_ruby(expected, actual)

    minitest_assert_predicate(object, predicate, message)
  rescue StandardError
    minitest_assert_predicate(object, predicate, msg)
  end
end
