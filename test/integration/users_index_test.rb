require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)     # admin user
    @non_admin = users(:archer)  # regular user
  end

  test "index as admin including pagination and delete links" do
    # Log in as admin
    log_in_as(@admin)
    assert is_logged_in?, "Admin should be logged in"

    # Visit users index
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'  # Check pagination exists

    # Check each user on first page
    first_page_of_users = User.where(activated: true).paginate(page: 1)

    first_page_of_users.each do |user|
      # Check user name link exists
      assert_select 'a[href=?]', user_path(user), text: user.name

      # Admin should see delete link for other users
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end

    # Test deleting a non-admin user
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    assert is_logged_in?, "Non-admin should be logged in"

    get users_path
    # Non-admin should not see any delete links
    assert_select 'a', text: 'delete', count: 0
  end
end
