# frozen_string_literal: true

module Difftastic
  module Patches
    module AssertOperator
      def assert_operator(object1, operator, object2 = UNDEFINED, msg = nil)
        msg ||= message(nil, "") {
          differ = ::Difftastic::Differ.new(
            color: :always,
            tab_width: 2,
            syntax_highlight: :off,
            left_label: "Expected",
            right_label: "to be #{operator}"
          )

          "\n#{differ.diff_objects(object1, object2)}"
        }

        super
      rescue StandardError
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
