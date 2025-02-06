# frozen_string_literal: true

require "example_helper"

module Examples
  class AssertOperator < Minitest::Test
    def test_operator_case_equality
      assert_operator "Left", :===, "Right"
    end

    def test_operator_eql
      assert_operator 1, :eql?, 1.0
    end

    def test_operator_equal
      assert_operator 1, :equal?, 1.0
    end

    def test_operator_lt
      assert_operator 1, :>, 2
    end
  end
end
