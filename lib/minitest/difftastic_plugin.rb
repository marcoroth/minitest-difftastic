# frozen_string_literal: true

require "difftastic"

# TODO: use refinements
module Minitest
  module Assertions
    def diff(exp, act)
      ::Difftastic::Differ.new(color: :always, tab_width: 2, syntax_highlight: :off).diff_objects(exp, act)
    rescue StandardError
      super
    end
  end
end
