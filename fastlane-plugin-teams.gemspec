# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/teams/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-teams'
  spec.version       = Fastlane::Teams::VERSION
  spec.author        = %q{Morten Bøgh}
  spec.email         = %q{morten@justabeech.com}

  spec.summary       = %q{Send a success/error message to your Microsoft Teams channel}
  spec.homepage      = "https://github.com/mbogh/fastlane-plugin-teams"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 2.28.2'
end
