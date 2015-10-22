# Rails helper module for navigation
module Nyulibraries
  module Assets
    module NavHelper

      # Breadcrumbs
      def breadcrumbs
        breadcrumbs = []
        if breadcrumbs.empty?
          breadcrumbs << link_to(views["breadcrumbs"]["title"], views["breadcrumbs"]["url"])
          breadcrumbs << link_to('BobCat', bobcat_breadcrumb_root)
        end
      end

      # Login link and icon
      def login(params={})
        (current_user) ? link_to_logout(params) : link_to_login(params)
      end

      # Link to logout
      def link_to_logout(params={})
        icon_tag(:logout) +
          link_to("Log-out #{username}",
            logout_url(params), class: "logout")
      end

      # Link to login
      def link_to_login(params={})
        icon_tag(:login) + link_to("Login", login_url(params), class: "login")
      end

      def username
        if current_user.respond_to?(:firstname) && current_user.firstname.present?
          current_user.firstname
        else
          current_user.username
        end
      end

      def bobcat_breadcrumb_root
        "#{bobcat_breadcrumb_base_url}/#{bobcat_breadcrumb_alias}"
      end

      # Ensure there is always a bobcat url to show even if it isn't set anywhere
      def bobcat_breadcrumb_base_url
        (current_institution.bobcat_url) ? current_institution.bobcat_url : default_institution.bobcat_url
      rescue
        default_institution.bobcat_url
      end

      # Ensure there is always an alias to show even if it isn't set anywhere
      def bobcat_breadcrumb_alias
        (current_institution.bobcat_alias) ? current_institution.bobcat_alias : views["dir"]
      rescue
        views["dir"]
      end
    end
  end
end
