$:.unshift("#{File.dirname(__FILE__)}/..")
require 'test/unit'
require 'sass'
require 'sass/plugin'
require 'compass'
require 'bootstrap-sass'
require 'coffee-script'
require 'coveralls'
Coveralls.wear!
require File.expand_path("../../lib/nyulibraries_assets.rb",  __FILE__)
