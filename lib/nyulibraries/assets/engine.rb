module Nyulibraries
  module Assets
    class Engine < ::Rails::Engine
      require 'compass-rails'
      require 'bootstrap-sass'
      require 'institutions'
      require 'sprockets/railtie'
      initializer "#{engine_name}.asset_pipeline" do |app|
        app.config.assets.precompile += ['print.css']
        # Precompile institutional stylesheets
        Institutions.institutions.each_value do |institution|
          stylesheet = "#{institution.views["css"]}.css"
          app.config.assets.precompile << stylesheet unless (stylesheet.blank? or app.config.assets.precompile.include?(stylesheet))
        end
        app.config.compass.sprite_load_path << File.join(self.root, "lib", "assets", "images")
        path = self.root
        ActiveSupport.on_load(:action_controller) do
          append_view_path File.join(path, "app", "templates")
        end
        # For Rails 4, Sass::Script::Functions::EvaluationContext#generated_image_url tries
        # to do cachebusting, which causes problems (it may be outdated). This overrides that.
        if ActiveRecord::VERSION::MAJOR > 3
          Sass::Script::Functions::EvaluationContext.class_eval do
            include Sprockets::SassFunctions
            include ActionView::Helpers::AssetUrlHelper
            def generated_image_url(path, only_path = nil)
              Sass::Script::String.new(asset_url path)
            end
          end
        end
      end
    end
  end
end
