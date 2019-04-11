require 'test_helper'

class Welcome2ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome2_index_url
    assert_response :success
  end

end
