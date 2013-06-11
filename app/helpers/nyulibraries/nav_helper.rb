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
      (current_user) ?
        icon_tag(:logout) + link_to("Log-out #{current_user.firstname}", logout_url(params), class: "logout") :
          icon_tag(:login) + link_to("Login", login_url(params), class: "login")
    end
  end
end
