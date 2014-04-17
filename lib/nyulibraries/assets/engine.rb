module Nyulibraries
  module Assets
    class Engine < ::Rails::Engine
      require 'bootstrap-sass'
      require 'institutions'
      require 'sprockets/railtie'
      require 'compass-rails'
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
        module Sass::Script::Functions
          include ActionView::Helpers::AssetUrlHelper
          def generated_image_url(path, only_path = nil)
            cachebust_generated_images
            Sass::Script::String.new(asset_url(path),:string)
          end
          def image_path(source, options = {})
            ::Sass::Script::String.new asset_url(source).to_s, :string
          end
        end
      end
    end
  end
end
