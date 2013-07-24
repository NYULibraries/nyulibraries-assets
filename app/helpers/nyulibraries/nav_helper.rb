module Nyulibraries
  module NavHelper

    # Breadcrumbs
    def breadcrumbs
      breadcrumbs = []
      if breadcrumbs.empty?
        breadcrumbs << link_to(views["breadcrumbs"]["title"], views["breadcrumbs"]["url"])
        breadcrumbs << link_to('BobCat', "http://bobcat.library.nyu.edu/#{views["dir"]}")
      end
    end

    # Login link and icon
    def login(params={})
      (current_user) ? link_to_logout(params) : link_to_login(params)
    end

    # Link to logout
    def link_to_logout(params={})
      icon_tag(:logout) +
        link_to("Log-out #{current_user.firstname}", 
          logout_url(params), class: "logout")
    end

    # Link to logout
    def link_to_login(params={})
      icon_tag(:login) + link_to("Login", login_url(params), class: "login")
    end
  end
end
