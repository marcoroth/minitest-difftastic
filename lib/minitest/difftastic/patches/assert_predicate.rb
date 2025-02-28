# frozen_string_literal: true

module Difftastic
  module Patches
    module AssertPredicate
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
            width: ::Minitest::Difftastic::Config.width,
            syntax_highlight: :on,
            left_label: "Expected",
            right_label: "Actual",
            context: expected.lines.count
          )

          "\n#{differ.diff_ruby(expected, actual)}"
        }

        super
      rescue StandardError
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
