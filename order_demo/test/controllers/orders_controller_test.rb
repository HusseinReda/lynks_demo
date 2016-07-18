require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { date: @order.date, status: @order.status, total: @order.total, user_id: @order.user_id }
    end

    assert_response 201
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should update order" do
    put :update, id: @order, order: { date: @order.date, status: @order.status, total: @order.total, user_id: @order.user_id }
    assert_response 204
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_response 204
  end
end
