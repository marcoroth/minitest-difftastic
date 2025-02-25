# frozen_string_literal: true

module Difftastic
  module Patches
    module Diff
      def diff(exp, act)
        case [exp, act]
        in [String => exp, String => act] if exp.include?("\n") || act.include?("\n")
          "\n#{::Minitest::Difftastic.string_differ.diff_strings(exp, act)}"
        else
          pretty_diff = ::Minitest::Difftastic.default_differ.diff_objects(exp, act)

          if pretty_diff.include?("No changes.")
            # defaults: max_width: 30, max_items: 10, max_depth: 5
            max_items = 50
            max_depth = 5

            pretty_diff = ::Minitest::Difftastic.default_differ.diff_ruby(
              PrettyPlease.prettify(exp, max_items: max_items, max_depth: max_depth),
              PrettyPlease.prettify(act, max_items: max_items, max_depth: max_depth)
            )
          end

          "\n#{pretty_diff}"
        end
      rescue StandardError => e
        puts "Minitest::Difftastic error: #{e.inspect} (#{e.backtrace[0]})"
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
