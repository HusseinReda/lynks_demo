class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    render json: @order
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      head :no_content
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy

    head :no_content
  end

  def get_order_id
    order = Order.where({:status => 'current', :user_id => params[:user_id]}).first
    if order.nil?
      order = Order.create( :status => 'current', :total => 0.0, :user_id => params[:user_id] )
    end
    render :json => { :order_id => order.id }
  end

  def order_history
    orders = Order.where({:status => 'purchased', :user_id => params[:user_id]})
    orders_history = []
    orders.each do |order|
      orders_history_resp = RestClient.get CART_URL + "old_items/#{order.id}", {:params => {:order_id => order.id}}
      orders_history << JSON.parse( orders_history_resp )
    end
    render :json => { :orders_history => orders_history }
  end

  def purchase
    order = Order.where({:status => 'current', :user_id => params[:user_id]}).first
    if order
      order.status = 'complete'
      item_array = CartItem.where(:order_id => order.id)
      item_array.each do |item|
        puts item.item_id
        response = RestClient.put STORE_URL + "#{item.item_id}", {:consume => 'true'}
      end
      order.save!
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:date, :status, :total, :user_id)
    end
end
