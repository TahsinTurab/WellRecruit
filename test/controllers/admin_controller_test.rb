require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get approve_recruiter" do
    get admin_approve_recruiter_url
    assert_response :success
  end
end
