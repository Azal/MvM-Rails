require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

  test "should get test" do
    get :test
    assert_response :success
  end

end
