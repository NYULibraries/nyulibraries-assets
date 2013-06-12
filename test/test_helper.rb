$:.unshift("#{File.dirname(__FILE__)}/..")
require 'test/unit'
require 'sass'
require 'sass/plugin'
require 'sass/rails'
require 'compass'
require 'bootstrap-sass'
require 'coffee-script'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require "rails/test_help"
require File.expand_path("../../lib/nyulibraries_assets.rb",  __FILE__)
require 'coveralls'
Coveralls.wear!

class ActionView::TestCase
  def current_user
    DummyUser.new
  end

  def current_primary_institution
    Institutions.defaults.first
  end
end

class DummyUser
  def firstname
    "Dummy"
  end

  def lastname
    "User"
  end
end
