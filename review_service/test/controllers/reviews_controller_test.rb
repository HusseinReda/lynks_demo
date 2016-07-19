require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, review: { body: @review.body, item_id: @review.item_id, rating: @review.rating, user_id: @review.user_id }
    end

    assert_response 201
  end

  test "should show review" do
    get :show, id: @review
    assert_response :success
  end

  test "should update review" do
    put :update, id: @review, review: { body: @review.body, item_id: @review.item_id, rating: @review.rating, user_id: @review.user_id }
    assert_response 204
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
    end

    assert_response 204
  end
end
