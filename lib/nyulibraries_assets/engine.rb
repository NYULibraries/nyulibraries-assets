module NYULibrariesAssets
  module Rails
    class Engine < ::Rails::Engine
      require 'compass-rails'
      require 'bootstrap-sass'
      initializer "#{engine_name}.asset_pipeline" do |app|
        app.config.compass.sprite_load_path << File.join(self.root, "lib", "assets", "images")
      end
    end
  end
end