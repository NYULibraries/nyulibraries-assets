# Rails helper module for bobcat layout.
# Assumes
#     - Rails helper function
#     - AuthPdsNyu controller methods
module Nyulibraries
  module BobcatHelper

    # BobCat title
    def bobcat_title
      t('bobcat.title_html')
    end
  end
end
