require 'test_helper'
module Nyulibraries
  module Assets
    class WorkspaceHelperTest < ActionView::TestCase
      test "current user name" do
        assert_equal "Dummy User", current_user_name
      end

      test "guest user name" do
        assert_equal "Guest", guest_user_name
      end
    end
  end
end
