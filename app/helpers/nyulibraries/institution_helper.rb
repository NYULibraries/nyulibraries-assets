module Nyulibraries
  require 'institutions'
  module InstitutionHelper

    # Get the stylesheet base on the current institution.
    def institutional_stylesheet
      stylesheet_link_tag institution.views["css"]
    end

    def views
      institution.views
    end

    def institution
      current_primary_institution
    end

    def default_institution
      @default_institution ||= Institutions.defaults.first
    end
  end
end
