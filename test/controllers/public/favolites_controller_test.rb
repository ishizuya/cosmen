require "test_helper"

class Public::FavolitesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_favolites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_favolites_destroy_url
    assert_response :success
  end
end
