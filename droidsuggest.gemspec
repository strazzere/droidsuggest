# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "droidsuggest/version"

Gem::Specification.new do |s|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  s.name = "droidsuggest"
  s.version     = DroidSuggest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.homepage = "http://github.com/strazzere/droidsuggest"
  s.license = "MIT"
  s.summary = "Wrapper for the Android Market Search suggestions"
  s.description = "This gem will allow you to query the Android Market for an array of search suggestions, based on your query."
  s.email = "Tim.Strazzere@mylookout.com"
  s.authors = ["Tim Strazzere"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

#  s.add_dependency('activesupport', '>= 3.0.5')
  s.add_dependency('rake', '~> 0.9.2')

  # development dependencies 
  s.add_development_dependency('yard', '~> 0.7')
  s.add_development_dependency('rdiscount', '~> 1.6')
  s.add_development_dependency('rcov', '~> 0.9')

  # test dependencies 
  s.add_development_dependency('shoulda', '~> 2.11')
  s.add_development_dependency('turn', '0.8.2')
  s.add_development_dependency('fakeweb', '~> 1.3')
  s.add_development_dependency('mocha', '~> 0.10')
end