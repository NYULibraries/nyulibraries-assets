module NYULibrariesAssets
  class FrameworkNotFound < StandardError; end

  # Inspired by {bootstrap-sass}[https://github.com/thomas-mcdonald/bootstrap-sass]
  def self.load!
    register_compass_extension
    if asset_pipeline?
      register_rails_engine
    end
  end

  private
  def self.asset_pipeline?
    defined?(::Rails) && ::Rails.version >= '3.1.0'
  end

  def self.register_compass_extension
    base = File.join(File.dirname(__FILE__), '../', 'lib', 'assets')
    styles = File.join(base, "stylesheets")
    images = File.join('lib', 'assets', "images")
    ::Compass::Frameworks.register('nyulibraries', :path => base, :stylesheets_directory => styles)
    ::Compass.configuration.sprite_load_path << images
  end

  def self.register_rails_engine
    require 'nyulibraries_assets/engine'
  end
end

NYULibrariesAssets.load!