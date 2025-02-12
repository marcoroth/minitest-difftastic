# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/difftastic"
require "minitest/autorun"

require "set"
require "date"
require "pathname"

require_relative "snapshot_helper" if ENV["VERIFY_SNAPSHOTS"]
