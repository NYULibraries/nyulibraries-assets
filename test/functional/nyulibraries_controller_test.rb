require 'test_helper'

class NyulibrariesControllerTest < ActionController::TestCase
  test "should get application" do
    get :application
    assert_response :success
    assert_select "title", "Dummy Application"
    assert_select "header > div.suite > span", 0
    assert_select "header > div.application > span", {count: 1, text: "Dummy Application"}
    assert_select "header", 1
  end

  test "should get bobcat" do
    get :bobcat
    assert_response :success
    assert_select "title", "BobCat"
    assert_select "header", 1
    assert_select "header > div.suite > span", {count: 1, text: "BobCat"}
    assert_select "header > div.application > span", {count: 1, text: "Dummy Application"}
    assert_select "footer", 0
  end

  test "should get eshelf" do
    get :eshelf
    assert_response :success
    assert_select "title", "BobCat"
    assert_select "header", 1
    assert_select "header > div.suite > span", {count: 1, text: "BobCat"}
    assert_select "header > div.application > span", {count: 1, text: "Dummy Application"}
    assert_select "footer", 0
  end

  test "should get print" do
    get :print
    assert_response :success
    assert_select "title", "Dummy Application"
    assert_select "h1", {count: 1, text: "Dummy Application"}
    assert_select "header", 0
    assert_select "footer", 0
  end
end
