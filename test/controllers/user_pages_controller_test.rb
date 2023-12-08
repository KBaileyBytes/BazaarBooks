require "test_helper"

class UserPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_pages_show_url
    assert_response :success
  end
end
