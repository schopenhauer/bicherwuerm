require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorys)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Genre.count') do
      post :create, category: { description: @category.description, name: @category.name }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test 'should show category' do
    get :show, id: @category
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @category
    assert_response :success
  end

  test 'should update category' do
    patch :update, id: @category, category: { description: @category.description, name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test 'should destroy category' do
    assert_difference('Genre.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categorys_path
  end
end
