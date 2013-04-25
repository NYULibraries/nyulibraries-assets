# Rails helper module for bobcat layout.
# Assumes
#     - Rails helper function
#     - AuthPdsNyu controller methods
require 'active_support/concern'
module EshelfHelper
  extend ActiveSupport::Concern

  included do |klass|
    klass.class_eval {
      include NyulibrariesHelper
    }
  end

  # Title of application
  def title
    "BobCat"
  end

  # Footer
  def footer
    javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
  end

  # Username
  def username
    (current_user) ?
      "#{current_user.firstname} #{current_user.lastname}" : "Guest"
  end

  def workspace_header
    content_tag(:h2, class: "workspace") do
      content_tag(:span, "#{t('workspace.header_html')} ") + workspace_info
    end
  end

  def workspace_info
    link_to_workspace_info("http://library.nyu.edu/info/eshelf.html", "right")
  end

  def back_to
    (icon_tag(:back) + link_to_back) if link_to_back
  end

  def link_to_back
    nil
  end
end