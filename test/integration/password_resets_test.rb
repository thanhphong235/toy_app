require "test_helper"

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password resets" do
    # Truy cập form quên mật khẩu
    get new_password_reset_path
    assert_template 'password_resets/new'

    # Gửi email không hợp lệ
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'

    # Gửi email hợp lệ
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    # Lấy user vừa được controller gán
    user = assigns(:user)

    # Email sai
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url

    # User chưa kích hoạt
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)

    # Token sai
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url

    # Token và email đúng
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email

    # Mật khẩu và xác nhận không khớp
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password: "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'

    # Mật khẩu trống
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password: "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'

    # Mật khẩu hợp lệ
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password: "foobaz",
                            password_confirmation: "foobaz" } }

    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
