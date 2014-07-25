require 'test_helper'
require 'sass/rails'
ENV['RAILS_ENV'] = 'test'
require 'rails/test_help'
require File.expand_path("../dummy/config/environment", __FILE__)

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
