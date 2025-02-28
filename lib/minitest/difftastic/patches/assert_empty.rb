# frozen_string_literal: true

module Difftastic
  module Patches
    module AssertEmpty
      def assert_empty(obj, msg = nil)
        differ = ::Difftastic::Differ.new(
          color: :always,
          tab_width: 2,
          syntax_highlight: :off,
          left_label: "Expected",
          right_label: "Actual"
        )

        case obj
        when String
          msg = differ.diff_objects("", obj)
        when Symbol
          msg = differ.diff_objects(:"", obj)
        when Array
          msg = differ.diff_objects([], obj)
        when Set
          msg = differ.diff_objects(Set.new, obj)
        when SizedQueue
          msg = differ.diff_objects(SizedQueue.new(obj.max), obj)
        when Queue
          msg = differ.diff_objects(Queue.new, obj)
        when Pathname
          if obj.exist? && obj.directory?
            msg = differ.diff_objects([], obj.children)
          elsif obj.exist? && obj.file?
            msg = differ.diff_strings(" ", obj.read)
          end
        when Object
          msg = differ.diff_objects({}, obj)
        end

        super(obj, msg)
      rescue StandardError
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
