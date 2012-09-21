require 'test_helper'

class RcDataTypeTablesControllerTest < ActionController::TestCase
  setup do
    @rc_data_type_table = rc_data_type_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rc_data_type_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rc_data_type_table" do
    assert_difference('RcDataTypeTable.count') do
      post :create, rc_data_type_table: @rc_data_type_table.attributes
    end

    assert_redirected_to rc_data_type_table_path(assigns(:rc_data_type_table))
  end

  test "should show rc_data_type_table" do
    get :show, id: @rc_data_type_table.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rc_data_type_table.to_param
    assert_response :success
  end

  test "should update rc_data_type_table" do
    put :update, id: @rc_data_type_table.to_param, rc_data_type_table: @rc_data_type_table.attributes
    assert_redirected_to rc_data_type_table_path(assigns(:rc_data_type_table))
  end

  test "should destroy rc_data_type_table" do
    assert_difference('RcDataTypeTable.count', -1) do
      delete :destroy, id: @rc_data_type_table.to_param
    end

    assert_redirected_to rc_data_type_tables_path
  end
end
