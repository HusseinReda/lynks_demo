class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all

    render json: @cart_items
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
    render json: @cart_item
  end

  # GET /cart_items/exist
  def exist
    home_cart_items = CartItem.where(["order_id = ? and item_id = ?", params['order_id'], params['item_id']])
    
    render json: home_cart_items
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      render json: @cart_item, status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    @cart_item = CartItem.find(params[:id])

    if @cart_item.update(cart_item_params)
      head :no_content
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy

    head :no_content
  end

  private

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity, :price, :order_id)
    end
end
