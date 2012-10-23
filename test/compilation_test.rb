require 'test_helper'

class CompilationTest < Test::Unit::TestCase
  def test_scss_compilation
    ::Compass.configuration.images_dir = 'lib/assets/images'
    path = 'lib/assets/stylesheets'
    compiler = Compass::Compiler.new(path, path, path, :sass => Compass.sass_engine_options)
    %w(nyulibraries).each do |file|
      assert_nothing_raised do
        compiler.engine("#{path}/_#{file}.css.scss", "#{path}/_#{file}.css").render
      end
    end
  end

  def test_coffee_script_compilation
  end
end