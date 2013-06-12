require 'test_helper'
module Nyulibraries
  class WorkspaceHelperTest < ActionView::TestCase
    test "current user name" do
      assert_equal "Dummy User", current_user_name
    end

    test "guest user name" do
      assert_equal "Guest", guest_user_name
    end

    # Add for testing
    def current_user
      DummyUser.new
    end

    class DummyUser
      def firstname
        "Dummy"
      end

      def lastname
        "User"
      end
    end
  end
end
