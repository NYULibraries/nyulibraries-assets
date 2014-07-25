require 'rails_helper'
module Nyulibraries
  module Assets
    class BobcatHelperTest < ActionView::TestCase
      test "application title" do
        assert_equal "BobCat", bobcat_title
      end
    end
  end
end
