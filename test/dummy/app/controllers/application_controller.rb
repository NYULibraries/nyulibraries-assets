require 'institutions'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_primary_institution
    Institutions.institutions[:NYU]
  end
  helper_method :current_primary_institution

  def current_user
    nil
  end
  helper_method :current_user

  def login_url(*args)
    "https://login.library.nyu.edu"
  end
  helper_method :login_url
end
