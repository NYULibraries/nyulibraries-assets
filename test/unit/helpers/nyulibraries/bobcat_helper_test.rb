require 'test_helper'
module Nyulibraries
  class BobcatHelperTest < ActionView::TestCase
    test "application title" do
      assert_equal "BobCat", bobcat_title
    end
  end
end
