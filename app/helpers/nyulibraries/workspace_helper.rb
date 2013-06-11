# Rails helper module for bobcat layout.
# Assumes
#     - Rails helper function
#     - AuthPdsNyu controller methods
module Nyulibraries
  module WorkspaceHelper

    # Current user's name
    def current_user_name
      "#{current_user.firstname} #{current_user.lastname}" if current_user
    end

    # Guest name
    def guest_user_name
      t('workspace.guest_user_name_html')
    end

    # General workspace header
    def workspace_header
      content_tag(:h2, class: "workspace") do
        workspace_info + content_tag(:span, " #{t('workspace.header_html')}")
      end
    end

    # General workspace info link
    def workspace_info
      link_to_workspace_info("http://library.nyu.edu/info/myworkspace.html", "left")
    end

    # Return link to workspace info
    def link_to_workspace_info(url, placement)
      link_to(url, title: "#{t('workspace.title_html')}", target: "_blank", 
        data: { placement: placement, class: "workspace" }){ icon_tag(:help) }
    end
  end
end
