require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get upload_form" do
    get :upload_form
    assert_response :success
  end

end
