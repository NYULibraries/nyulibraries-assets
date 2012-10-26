module NYULibrariesAssets
  module Rails
    class Engine < ::Rails::Engine
      require 'compass-rails'
      require 'bootstrap-sass'
      require 'mustache/railtie'
      initializer "#{engine_name}.asset_pipeline" do |app|
        app.config.compass.sprite_load_path << File.join(self.root, "lib", "assets", "images")
        path = self.root
        ActiveSupport.on_load(:action_controller) do
          append_view_path File.join(path, "app", "templates")
        end
      end
    end
  end
end