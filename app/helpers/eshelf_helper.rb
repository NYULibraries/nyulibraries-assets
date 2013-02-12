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

  # Sidebar partial
  def sidebar
  end

  # Footer
  def footer
    javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
  end
end