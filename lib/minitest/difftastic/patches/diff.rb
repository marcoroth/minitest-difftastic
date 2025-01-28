# frozen_string_literal: true

module Minitest::Assertions
  alias minitest_diff diff

  def diff(exp, act)
    ::Minitest::Difftastic::DEFAULT_DIFFER.diff_objects(exp, act)
  rescue StandardError => e
    puts "Minitest::Difftastic error: #{e.inspect} (#{e.backtrace[0]})"
    minitest_diff(exp, act)
  end
end
