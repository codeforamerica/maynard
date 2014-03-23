require 'test_helper'

class ContractingOfficersControllerTest < ActionController::TestCase
  setup do
    @contracting_officer = contracting_officers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracting_officers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contracting_officer" do
    assert_difference('ContractingOfficer.count') do
      post :create, contracting_officer: { email_address: @contracting_officer.email_address, first_name: @contracting_officer.first_name, last_name: @contracting_officer.last_name }
    end

    assert_redirected_to contracting_officer_path(assigns(:contracting_officer))
  end

  test "should show contracting_officer" do
    get :show, id: @contracting_officer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contracting_officer
    assert_response :success
  end

  test "should update contracting_officer" do
    patch :update, id: @contracting_officer, contracting_officer: { email_address: @contracting_officer.email_address, first_name: @contracting_officer.first_name, last_name: @contracting_officer.last_name }
    assert_redirected_to contracting_officer_path(assigns(:contracting_officer))
  end

  test "should destroy contracting_officer" do
    assert_difference('ContractingOfficer.count', -1) do
      delete :destroy, id: @contracting_officer
    end

    assert_redirected_to contracting_officers_path
  end
end
