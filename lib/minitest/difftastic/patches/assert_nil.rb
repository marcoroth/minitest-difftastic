# frozen_string_literal: true

module Difftastic
  module Patches
    module AssertNil
      def assert_nil(obj, msg = nil)
        msg ||= message(nil, "") {
          differ = ::Difftastic::Differ.new(
            color: :always,
            tab_width: 2,
            width: ::Minitest::Difftastic::Config.width,
            syntax_highlight: :off,
            left_label: "Expected",
            right_label: "Actual"
          )

          "\n#{differ.diff_objects(nil, obj)}"
        }
        super
      rescue StandardError
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
