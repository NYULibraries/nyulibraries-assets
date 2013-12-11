# Rails helper module for applcations 
module Nyulibraries
  module Assets
    module ApplicationHelper

      # This engine
      def nyulibraries_assets
        ::Rails.application.railties.engines.find do |engine|
          engine.class.name.eql? Nyulibraries::Assets::Engine.name
        end
      end

      # Root of this engine
      def nyulibraries_assets_root
        nyulibraries_assets.root unless nyulibraries_assets.blank?
      end

      # Application title
      # Returns application.title_html from the locale
      def application_title
        t('application.title_html')
      end

      # Application stylesheet
      def application_stylesheet
        stylesheet_link_tag "application"
      end

      # Application javascript
      def application_javascript
        javascript_include_tag "application"
      end

      # Meta tags for the application
      def meta
        tag(:meta, :charset => "utf-8") +
        tag(:meta, :name => "viewport",
          :content => "width=device-width, initial-scale=1.0")+
        tag(:meta, :name => "HandheldFriendly", :content => "True")+
        tag(:meta, 'http-equiv' => "cleartype", :content => "on")+
        favicon_link_tag('https://library.nyu.edu/favicon.ico')+
        csrf_meta_tags
      end

      # Return true if delayed_jobs gem has any jobs running
      def delayed_jobs_running?
        (defined?(Delayed::Job) and Delayed::Job.count > 0)
      end
    end
  end
end
