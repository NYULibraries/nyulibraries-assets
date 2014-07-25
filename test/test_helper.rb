require 'coveralls'
Coveralls.wear!
$:.unshift("#{File.dirname(__FILE__)}/..")
require 'test/unit'
require 'pry'
require File.expand_path("../../lib/nyulibraries-assets.rb",  __FILE__)
