# frozen_string_literal: true

require "example_helper"

module Examples
  class AssertNil < Minitest::Test
    def test_assert_nil_with_string
      assert_nil "String"
    end

    def test_assert_nil_with_true
      assert_nil true
    end

    def test_assert_nil_with_false
      assert_nil false
    end
  end
end
