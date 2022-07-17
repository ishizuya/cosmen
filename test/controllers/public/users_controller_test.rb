require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_users_update_url
    assert_response :success
  end

  test "should get diagnosis" do
    get public_users_diagnosis_url
    assert_response :success
  end

  test "should get result" do
    get public_users_result_url
    assert_response :success
  end

  test "should get save" do
    get public_users_save_url
    assert_response :success
  end
end
