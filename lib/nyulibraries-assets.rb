module Nyulibraries
  module Assets
    class FrameworkNotFound < StandardError; end

    require 'compass'
    require 'bootstrap-sass'
    require 'institutions'

    # Inspired by {bootstrap-sass}[https://github.com/thomas-mcdonald/bootstrap-sass]
    def self.load!
      register_compass_extension
      if asset_pipeline?
        register_rails_engine
      end
      # Set the common institutions file at the front of the load paths.
      Institutions.loadpaths.unshift  File.join(File.dirname(__FILE__), '../', 'config')
    end

    private
    def self.asset_pipeline?
      defined?(::Rails) && ::Rails.version >= '3.1.0'
    end

    def self.register_compass_extension
      base = File.join(File.dirname(__FILE__), "..")
      styles = File.join(base, "lib", "assets", "stylesheets")
      images = File.join(base, "lib", "assets", "images")
      templates = File.join(base, "templates")
      ::Compass::Frameworks.register('nyulibraries-assets', path: base, 
        stylesheets_directory: styles, templates_directory: templates)
      ::Compass.configuration.sprite_load_path << images
    end

    def self.register_rails_engine
      require 'nyulibraries/assets/engine'
    end
  end
end
# Load 'em up
Nyulibraries::Assets.load!
