# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_assert_predicate assert_predicate

  def assert_predicate(object, predicate, msg = nil)
    msg ||= message(nil, "") {
      pretty = Difftastic.pretty(object)

      expected = <<~RUBY
        #{pretty}.#{predicate}

        # => true
      RUBY

      actual = <<~RUBY
        #{pretty}.#{predicate}

        # => false
      RUBY

      differ = ::Difftastic::Differ.new(
        color: :always,
        tab_width: 2,
        syntax_highlight: :on,
        left_label: "Expected",
        right_label: "Actual",
        context: expected.lines.count
      )

      "\n#{differ.diff_ruby(expected, actual)}"
    }

    minitest_assert_predicate(object, predicate, msg)
  rescue StandardError
    minitest_assert_predicate(object, predicate, msg)
  end
end
