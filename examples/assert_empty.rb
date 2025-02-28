# frozen_string_literal: true

require "example_helper"

module Examples
  class AssertEmpty < Minitest::Test
    def test_assert_empty_string
      assert_empty "String"
    end

    def test_assert_empty_symbol
      assert_empty :Symbol
    end

    def test_assert_empty_array
      assert_empty([1, 2, 3])
    end

    def test_assert_empty_object
      assert_empty({ id: 1 })
    end

    def test_assert_empty_set
      assert_empty(Set.new([1, 2, 3]))
    end

    def test_assert_empty_pathname_directory
      assert_empty(Pathname.new("lib/minitest"))
    end

    def test_assert_empty_pathname_file
      assert_empty(Pathname.new("bin/console"))
    end

    def test_assert_empty_queue
      queue = Queue.new
      queue << 1
      queue << 2

      assert_empty(queue)
    end

    def test_assert_empty_sized_queue
      queue = SizedQueue.new(10)
      queue << 1
      queue << 2

      assert_empty(queue)
    end
  end
end
