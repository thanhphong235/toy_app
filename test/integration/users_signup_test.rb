require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # Test đăng ký với thông tin không hợp lệ
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    # Kiểm tra render lại form new với lỗi
    assert_template 'users/new'
    assert_select 'div#error_explanation'        # Hiển thị lỗi tổng
    assert_select 'div.field_with_errors'       # Các field lỗi
  end

  # Test đăng ký với thông tin hợp lệ
  test "valid signup information" do
    get signup_path
    # Email đảm bảo unique để tránh lỗi validation uniqueness
    email = "user_#{Time.now.to_i}@example.com"
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: email,
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?  # Kiểm tra user tự động login sau signup
  end
end
