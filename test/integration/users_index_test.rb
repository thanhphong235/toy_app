require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)     # fixture admin: true
    @non_admin = users(:archer)  # fixture admin: false
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    assert is_logged_in?

    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'

    users = User.where(activated: true).paginate(page: 1)
    users.each do |user|
      # Check user name link
      assert_select 'a[href=?]', user_path(user), text: user.name
      # Admin sees delete link for others
      if user != @admin
        assert_select 'a', text: 'delete', href: user_path(user)
      end
    end

    # Delete a non-admin user
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    assert is_logged_in?

    get users_path
    assert_template 'users/index'

    # Non-admin should not see delete links
    assert_select 'a', text: 'delete', count: 0
  end
end
