require 'test_helper'

class NyulibrariesControllerTest < ActionController::TestCase
  test "should get application" do
    get :application
    assert_response :success
  end

  test "should get bobcat" do
    get :bobcat
    assert_response :success
  end

  test "should get eshelf" do
    get :eshelf
    assert_response :success
  end

  test "should get print" do
    get :print
    assert_response :success
  end
end
