# frozen_string_literal: true

module Difftastic
  module Patches
    module Diff
      def diff(exp, act)
        case [exp, act]
        in [String => exp, String => act] if exp.include?("\n") || act.include?("\n")
          "\n#{::Minitest::Difftastic::STRING_DIFFER.diff_strings(exp, act)}"
        else
          "\n#{::Minitest::Difftastic::DEFAULT_DIFFER.diff_objects(exp, act)}"
        end
      rescue StandardError => e
        puts "Minitest::Difftastic error: #{e.inspect} (#{e.backtrace[0]})"
        super
      end

      Minitest::Assertions.prepend(self)
    end
  end
end
