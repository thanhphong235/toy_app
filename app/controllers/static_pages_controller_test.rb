require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "h1", "Sample App"
  end

  test "should get help" do
    get '/help'
    assert_response :success
    assert_select "h1", "Help"
  end

  test "should get about" do
    get '/about'
    assert_response :success
    assert_select "h1", "About"
  end
end
