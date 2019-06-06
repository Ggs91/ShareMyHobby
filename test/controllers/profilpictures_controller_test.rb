require 'test_helper'

class ProfilpicturesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get profilpictures_create_url
    assert_response :success
  end

end
