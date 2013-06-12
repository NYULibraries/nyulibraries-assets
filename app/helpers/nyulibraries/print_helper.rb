module Nyulibraries
  module PrintHelper

    def print_title
      application_title
    end

    # Print stylesheet
    # Media type defaults to print
    def print_stylesheet(media = :print)
      stylesheet_link_tag "print", media: media
    end

    # Should we display the print stylesheet?
    def print_stylesheet?
      false
    end

    # Print javascript
    def print_javascript
      javascript_include_tag "print"
    end
  end
end
