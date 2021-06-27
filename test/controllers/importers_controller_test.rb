require "test_helper"

class ImportersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "should get index" do
    get root_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to importers_path
    follow_redirect!
    assert_template 'importers/index'
    assert_response :success
  end
end
