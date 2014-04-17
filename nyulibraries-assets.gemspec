$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nyulibraries/assets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nyulibraries-assets"
  s.version     = Nyulibraries::Assets::VERSION
  s.authors     = ["Scot Dalton"]
  s.email       = ["scot.dalton@nyu.edu"]
  s.homepage    = "https://github.com/NYULibraries/nyulibraries-assets"
  s.summary     = "Shared assets for http://library.nyu.edu and related sites based on Twitter Bootstrap."
  s.description = "Shared assets for http://library.nyu.edu and related sites based on Twitter Bootstrap. Requires Rails and/or Compass."
  s.license     = 'MIT'

  s.files       = `git ls-files`.split($\)
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "compass", "0.12.5"
  s.add_dependency "bootstrap-sass", "2.3.2.2"
  s.add_dependency "institutions", "~> 0.1.1"


  s.add_development_dependency "rake", "10.1.1"
  s.add_development_dependency "rails", "4.1.0"
  s.add_development_dependency "compass-rails", "1.1.7"
  s.add_development_dependency "coffee-script", "2.2.0"
  s.add_development_dependency "sass-rails", "4.0.3"
  # Fix to 0.99.4 cuz 0.99.5 broke my shit.
  s.add_development_dependency "mustache", "0.99.4"
  s.add_development_dependency "test-unit"
end
