require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  # ==========================
  # Index / New / Create
  # ==========================
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: { 
        name: "New User #{SecureRandom.hex(3)}", 
        email: "newuser#{SecureRandom.hex(3)}@example.com",
        password: "password",
        password_confirmation: "password"
      } }
    end
    assert_redirected_to user_url(User.last)
  end

  # ==========================
  # Show / Edit / Update
  # ==========================
  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should get edit when logged in as correct user" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user when logged in as correct user" do
    log_in_as(@user)
    patch user_path(@user), params: { user: { name: "Updated Name", email: "updated@example.com" } }
    assert_redirected_to @user
    @user.reload
    assert_equal "Updated Name", @user.name
  end

  # ==========================
  # Admin & Destroy
  # ==========================
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password: "password",
              password_confirmation: "password",
              admin: true }
    }
    @other_user.reload
    assert_not @other_user.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should destroy user when logged in as admin" do
    log_in_as(@user) # michael is admin
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
    assert_redirected_to users_url
  end
end
