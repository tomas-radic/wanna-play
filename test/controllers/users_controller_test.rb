require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get password_change" do
    get users_password_change_url
    assert_response :success
  end

end
