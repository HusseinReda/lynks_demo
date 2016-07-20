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

  def add_item
    order = Order.where({:status =>'current', :user_id => params[:user_id]}).first
    if order.nil?
      Order.create( :status => 'current', total => 0.0, user_id => params[:user_id] )
    end
    response = RestClient.get 'http://localhost:3001/items/query', {:params => {:item_id => params[:item_id]}}
    if response.code != 200
      puts 'eh da'
    else
      response_data = JSON.parse response
      if response_data["in_stock"] && response_data["in_stock"] == true
        puts "HHHHHHHHHHHHHHHHHHH    ", cart_item_response
        cart_item_response = RestClient.get 'http://localhost:3002/cart_items/exist', {:params => {:order_id => order.id, :item_id => params[:item_id]}}
        puts "HHHHHHHHHHHHHHHHHHH    ", cart_item_response
        # cart_item = JSON.parse( cart_item_response )
        # if cart_item.empty
        #   RestClient.put 'http://localhost:3002/cart_item/#{cart_item[\'cart_items\'][0][\'id\']}', {:params => {:item_id => params[:item_id], :quantity => cart_item['cart_items'][0]['quantity'] + params[:quantity], :price => params[:price], :order_id => order.id }}
        # else
          CartItem.create( :item_id => params[:item_id], :quantity => params[:quantity], :price => params[:price], :order_id => order.id)
        # end
        render :json => {:in_stock => response_data["in_stock"]}
      end
    end
  end

  def remove_item
    order = Order.where({:status => 'current', :user_id => params[:user_id]}).first
    if order
      item = CartItem.destroy_all({:order_id => order.id, :item_id => params[:item_id]})
    end
  end

  def purchase
    order = Order.where({:status => 'current', :user_id => params[:user_id]}).first
    if order
      order.status = 'complete'
      item_array = CartItem.where(:order_id => order.id)
      item_array.each do |item|
        puts item.item_id
        response = RestClient.put "http://localhost:3000/items/#{item.item_id}", {:consume => 'true'}
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
