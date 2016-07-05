require 'test_helper'

class BloodGlucoseLevelsControllerTest < ActionController::TestCase
  setup do
    @blood_glucose_level = blood_glucose_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blood_glucose_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blood_glucose_level" do
    assert_difference('BloodGlucoseLevel.count') do
      post :create, blood_glucose_level: { data: @blood_glucose_level.data, recorded_at: @blood_glucose_level.recorded_at, user: @blood_glucose_level.user }
    end

    assert_redirected_to blood_glucose_level_path(assigns(:blood_glucose_level))
  end

  test "should show blood_glucose_level" do
    get :show, id: @blood_glucose_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blood_glucose_level
    assert_response :success
  end

  test "should update blood_glucose_level" do
    patch :update, id: @blood_glucose_level, blood_glucose_level: { data: @blood_glucose_level.data, recorded_at: @blood_glucose_level.recorded_at, user: @blood_glucose_level.user }
    assert_redirected_to blood_glucose_level_path(assigns(:blood_glucose_level))
  end

  test "should destroy blood_glucose_level" do
    assert_difference('BloodGlucoseLevel.count', -1) do
      delete :destroy, id: @blood_glucose_level
    end

    assert_redirected_to blood_glucose_levels_path
  end
end
