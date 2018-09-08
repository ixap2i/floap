require 'test_helper'

class FlowersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flowers_index_url
    assert_response :success
  end

end
