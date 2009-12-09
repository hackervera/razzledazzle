require 'test_helper'

class OpenidUsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:openid_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create openid_user" do
    assert_difference('OpenidUser.count') do
      post :create, :openid_user => { }
    end

    assert_redirected_to openid_user_path(assigns(:openid_user))
  end

  test "should show openid_user" do
    get :show, :id => openid_users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => openid_users(:one).to_param
    assert_response :success
  end

  test "should update openid_user" do
    put :update, :id => openid_users(:one).to_param, :openid_user => { }
    assert_redirected_to openid_user_path(assigns(:openid_user))
  end

  test "should destroy openid_user" do
    assert_difference('OpenidUser.count', -1) do
      delete :destroy, :id => openid_users(:one).to_param
    end

    assert_redirected_to openid_users_path
  end
end
