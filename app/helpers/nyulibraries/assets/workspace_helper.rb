# Rails helper module for "My Workspace"
module Nyulibraries
  module Assets
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
          content_tag(:span, " #{t('workspace.header_html')}")
        end
      end

    end
  end
end
