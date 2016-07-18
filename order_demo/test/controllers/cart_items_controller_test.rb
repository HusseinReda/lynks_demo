require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase
  setup do
    @cart_item = cart_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_items)
  end

  test "should create cart_item" do
    assert_difference('CartItem.count') do
      post :create, cart_item: { item_id: @cart_item.item_id, order_id: @cart_item.order_id, price: @cart_item.price, quantity: @cart_item.quantity }
    end

    assert_response 201
  end

  test "should show cart_item" do
    get :show, id: @cart_item
    assert_response :success
  end

  test "should update cart_item" do
    put :update, id: @cart_item, cart_item: { item_id: @cart_item.item_id, order_id: @cart_item.order_id, price: @cart_item.price, quantity: @cart_item.quantity }
    assert_response 204
  end

  test "should destroy cart_item" do
    assert_difference('CartItem.count', -1) do
      delete :destroy, id: @cart_item
    end

    assert_response 204
  end
end
