module Nyulibraries
  module TabsHelper

    # Tabs header for bootstrap responsive nav bar
    def tabs_header
      application_title
    end

    # Show tabs
    def show_tabs
      return !tabs.empty?
    end

    # Tabs
    def tabs
      @tabs ||= views["tabs"].collect{|code, values|
        values["code"] = code
        values["url"], values["klass"] = root_url, "active" if active_tab? code
        values["link"] = link_to_with_popover(values["display"], values["url"], values["tip"], "tab")
        values
      }
    end
    alias all_tabs tabs

    # Is the given tab code active?
    def active_tab? code
      institution.active_tab.eql? code if institution.respond_to? :active_tab
    end
  end
end
