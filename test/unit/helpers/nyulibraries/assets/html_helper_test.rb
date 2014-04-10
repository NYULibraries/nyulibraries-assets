require 'test_helper'
module Nyulibraries
  module Assets
    class HtmlHelperTest < ActionView::TestCase
      test "check dropdown returns proper html" do
        button_html = "<div class=\"btn-group\"><button class=\"btn\" data-toggle=\"dropdown\">Test Title</button><button class=\"btn dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\" style=\"margin-top: 8px;\"></span></button><ul class=\"dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>"
        assert_equal button_html, button_dropdown("Test Title", ["Test Value 1","Test Value 2"])
        button_html_toggle_off = "<div class=\"btn-group\"><button class=\"btn\">Test Title</button><button class=\"btn dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\" style=\"margin-top: 8px;\"></span></button><ul class=\"dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>"
        assert_equal button_html_toggle_off, button_dropdown("Test Title", ["Test Value 1","Test Value 2"], false)
      end

      test "check right button dropdown returns proper html" do
        right_button_html = "<div class=\"btn-group pull-right\"><button class=\"btn\" data-toggle=\"dropdown\">Test Title</button><button class=\"btn dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\" style=\"margin-top: 8px;\"></span></button><ul class=\"pull-right dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>"
        assert_equal right_button_html,right_button_dropdown("Test Title", ["Test Value 1","Test Value 2"])
        right_button_html_toggle_off = "<div class=\"btn-group pull-right\"><button class=\"btn\">Test Title</button><button class=\"btn dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\" style=\"margin-top: 8px;\"></span></button><ul class=\"pull-right dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>"
        assert_equal right_button_html_toggle_off,right_button_dropdown("Test Title", ["Test Value 1","Test Value 2"], false)
      end

      test "check tooltip html" do
        skip("Skipping for rails 4, Rails 4 handles html tags differntly") if(ActiveRecord::VERSION::MAJOR > 3)
        tooltip_html = "<a href=\"#\" class=\"help-inline record-help\" data-placement=\"right\" rel=\"tooltip\" target=\"_blank\" title=\"test\">This is a test tooltip</a>"
        assert_equal tooltip_html, tooltip_tag("This is a test tooltip", "test")
      end

      test "check content-type tag" do
        essay_content_html = "<figure class=\"content-type\"><i class=\"icons-nyu-content-type-essay\"></i><figcaption>Essay</figcaption></figure>"
        assert_equal essay_content_html, content_type_tag("essay")
      end
    end
  end
end
