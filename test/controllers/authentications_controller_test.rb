require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  test "should get google" do
    get :google
    assert_response :success
  end

end
