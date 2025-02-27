# frozen_string_literal: true

require "example_helper"

module Examples
  class AssertPredicate < Minitest::Test
    def test_assert_predicate_array_empty
      assert_predicate [1], :empty?
    end

    def test_assert_predicate_string_empty
      assert_predicate "1", :empty?
    end

    def test_assert_predicate_object_empty
      assert_predicate({ id: 1 }, :empty?)
    end

    def test_assert_predicate_string_frozen
      assert_predicate(+"", :frozen?)
    end

    if Gem::Version.new(RUBY_VERSION) >= "3.2"
      def test_assert_predicate_with_custom_method
        test = Data.define(:enabled) do
          def self.name
            "Config"
          end

          def enabled?
            enabled
          end
        end

        assert_predicate test.new(enabled: false), :enabled?
      end
    end
  end
end
