# frozen_string_literal: true

require "example_helper"

module Examples
  class AssertEqual < Minitest::Test
    def test_assert_equal_string
      assert_equal "Hello World", "Hello Difftastic"
    end

    def test_assert_equal_with_nil
      assert_equal nil, "nil"
    end

    def test_assert_equal_with_integer
      assert_equal 1, "1"
    end

    def test_assert_equal_with_hash
      assert_equal({ id: 1 }, { id: 2 })
    end

    def test_assert_equal_with_nested_hash
      expected = {
        id: 1,
        data: {
          name: "John A.",
          tags: ["tag1", "tag2", "tag3"]
        }
      }

      actual = {
        id: 1,
        data: {
          name: "John B.",
          tags: ["tag1", "tag3", "tag2"]
        }
      }

      assert_equal expected, actual
    end

    def test_assert_equal_string_with_newlines
      expected = <<~RUBY
        class User < ApplicationRecord
          has_many :posts
        end
      RUBY

      actual = <<~RUBY
        class User < ApplicationRecord
          has_many :posts
          ^^^^^^^^^^^^^^^ Rubocop::SomeRule Missing association to `organization`
        end
      RUBY

      assert_equal expected, actual
    end

    def test_assert_equal_string_with_newlines_on_one_side
      expected = <<~RUBY
        Hello

        World
      RUBY

      actual = "Hello"

      assert_equal expected, actual
    end
  end
end
