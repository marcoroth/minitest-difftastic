# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_assert_empty assert_empty

  def assert_empty(obj, msg = nil)
    differ = ::Difftastic::Differ.new(
      color: :always,
      tab_width: 2,
      syntax_highlight: :off,
      left_label: "Expected to be empty",
      right_label: "Actual"
    )

    case obj
    when String
      msg = differ.diff_objects("", obj)
    when Symbol
      msg = differ.diff_objects(:"", obj)
    when Array
      msg = differ.diff_objects([], obj)
    when Object
      msg = differ.diff_objects({}, obj)
    when Set
      msg = differ.diff_objects(Set.new, obj)
    when Queue
      msg = differ.diff_objects(Queue.new, obj)
    when Pathname
      msg = differ.diff_objects(Pathname.new(""), obj)
    end

    minitest_assert_empty(obj, msg)
  end
end
