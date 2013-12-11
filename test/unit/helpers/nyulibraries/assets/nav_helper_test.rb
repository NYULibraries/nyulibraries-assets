require 'test_helper'
module Nyulibraries
  module Assets
    class NavHelperTest < ActionView::TestCase
      include Nyulibraries::Assets::InstitutionHelper
      test "breadcrumbs" do
        assert_equal ["<a href=\"http://library.nyu.edu\">NYU Libraries</a>",
         "<a href=\"http://bobcat.library.nyu.edu/nyu\">BobCat</a>"], breadcrumbs
      end
    end
  end
end
