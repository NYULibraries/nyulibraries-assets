require 'test_helper'
module Nyulibraries
  class ApplicationHelperTest < ActionView::TestCase
    test "application title" do
      assert_equal "Dummy Application", application_title
    end

    test "application stylesheet" do
      assert_equal("<link href=\"/stylesheets/application.css\" " +
        "media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />", 
          application_stylesheet)
    end

    test "application javascript" do
      assert_equal("<script src=\"/javascripts/application.js\" " +
        "type=\"text/javascript\"></script>", application_javascript)
    end
    
    test "delayed job" do
      assert !delayed_jobs_running?
    end
  end
end
