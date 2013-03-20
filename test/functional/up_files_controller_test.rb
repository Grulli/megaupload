require 'test_helper'

class UpFilesControllerTest < ActionController::TestCase
  setup do
    @up_file = up_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:up_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create up_file" do
    assert_difference('UpFile.count') do
      post :create, up_file: { Url: @up_file.Url, mail: @up_file.mail }
    end

    assert_redirected_to up_file_path(assigns(:up_file))
  end

  test "should show up_file" do
    get :show, id: @up_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @up_file
    assert_response :success
  end

  test "should update up_file" do
    put :update, id: @up_file, up_file: { Url: @up_file.Url, mail: @up_file.mail }
    assert_redirected_to up_file_path(assigns(:up_file))
  end

  test "should destroy up_file" do
    assert_difference('UpFile.count', -1) do
      delete :destroy, id: @up_file
    end

    assert_redirected_to up_files_path
  end
end
