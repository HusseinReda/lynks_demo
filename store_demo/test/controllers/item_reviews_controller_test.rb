require 'test_helper'

class ItemReviewsControllerTest < ActionController::TestCase
  setup do
    @item_review = item_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_reviews)
  end

  test "should create item_review" do
    assert_difference('ItemReview.count') do
      post :create, item_review: { body: @item_review.body, item_id: @item_review.item_id, rating: @item_review.rating, user_id: @item_review.user_id }
    end

    assert_response 201
  end

  test "should show item_review" do
    get :show, id: @item_review
    assert_response :success
  end

  test "should update item_review" do
    put :update, id: @item_review, item_review: { body: @item_review.body, item_id: @item_review.item_id, rating: @item_review.rating, user_id: @item_review.user_id }
    assert_response 204
  end

  test "should destroy item_review" do
    assert_difference('ItemReview.count', -1) do
      delete :destroy, id: @item_review
    end

    assert_response 204
  end
end
