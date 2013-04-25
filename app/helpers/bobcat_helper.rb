# Rails helper module for bobcat layout.
# Assumes
#     - Rails helper function
#     - AuthPdsNyu controller methods
require 'active_support/concern'
require 'institutions'
module BobcatHelper
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

  def workspace_header
    content_tag(:h2, class: "workspace") do
      workspace_info + content_tag(:span, " #{t('workspace.header_html')}")
    end
  end

  def workspace_info
    link_to_workspace_info("http://library.nyu.edu/info/myworkspace.html", "left")
  end

  def link_to_workspace_info(url, placement)
    link_to(url, title: "#{t('workspace.title_html')}", target: "_blank", 
      data: { placement: placement, class: "workspace" }){ icon_tag(:help) }
  end

  # Footer
  def footer
    javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
  end
end