require 'rails_helper'
# For skipping tests
require 'test/unit/omission'
module Nyulibraries
  module Assets
    class ApplicationHelperTest < ActionView::TestCase
      test "application title" do
        assert_equal "Dummy Application", application_title
      end

      test "application stylesheet" do
        skip("Skipping for rails 4, Rails 4 handles html tags differently") if(ActiveRecord::VERSION::MAJOR > 3)
        assert_equal("<link href=\"/stylesheets/application.css\" " +
          "media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />",
            application_stylesheet)
      end

      test "application javascript" do
        skip("Skipping for rails 4, Rails 4 handles html tags differently") if(ActiveRecord::VERSION::MAJOR > 3)
        assert_equal("<script src=\"/javascripts/application.js\" " +
          "type=\"text/javascript\"></script>", application_javascript)
      end

      test "delayed job" do
        assert !delayed_jobs_running?
      end
    end
  end
end
