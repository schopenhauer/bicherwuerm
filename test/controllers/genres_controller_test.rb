require 'test_helper'

class GenresControllerTest < ActionController::TestCase
  setup do
    @genre = genres(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:genres)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create genre' do
    assert_difference('genre.count') do
      post :create, genre: { description: @genre.description, name: @genre.name }
    end

    assert_redirected_to genre_path(assigns(:genre))
  end

  test 'should show genre' do
    get :show, id: @genre
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @genre
    assert_response :success
  end

  test 'should update genre' do
    patch :update, id: @genre, genre: { description: @genre.description, name: @genre.name }
    assert_redirected_to genre_path(assigns(:genre))
  end

  test 'should destroy genre' do
    assert_difference('genre.count', -1) do
      delete :destroy, id: @genre
    end

    assert_redirected_to genres_path
  end
end
