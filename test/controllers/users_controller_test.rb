require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get signup_path
    assert_response :success
  end

  test "should get login (root path)" do
    get root_path
    assert_response :success
  end
end
