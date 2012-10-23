# NYULibraries Assets
[![Build Status](https://secure.travis-ci.org/NYULibraries/nyulibraries_assets.png)](http://travis-ci.org/NYULibraries/nyulibraries_assets)
[![Dependency Status](https://gemnasium.com/NYULibraries/nyulibraries_assets.png)](https://gemnasium.com/NYULibraries/nyulibraries_assets)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/NYULibraries/nyulibraries_assets)

## Usage
### Rails
In your gemfile,

    group :assets do
      ...
      gem 'sass-rails', "~> 3.2.5"
      gem 'compass-rails', "~> 1.0.3"
      gem 'nyulibraries_assets', :git => "git://github.com/NYULibraries/nyulibraries_assets.git"
      ...
    end