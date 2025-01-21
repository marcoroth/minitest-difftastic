# frozen_string_literal: true

require_relative "lib/minitest/difftastic/version"

Gem::Specification.new do |spec|
  spec.name = "minitest-difftastic"
  spec.version = Minitest::Difftastic::VERSION
  spec.authors = ["Marco Roth"]
  spec.email = ["marco.roth@intergga.ch"]

  spec.summary = "Minitest Plugin to use difftastic for failed assertions"
  spec.description = spec.summary
  spec.homepage = "https://github.com/marcoroth/minitest-difftastic"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "difftastic", "~> 0.0.1"
end
