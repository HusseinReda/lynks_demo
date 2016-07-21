class CartItemsController < ApplicationController
	before_action :set_cart_item, only: [:show, :destroy]
	
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

		if @cart_item.update( cart_item_params )
		  head :no_content
		else
		  render json: @cart_item.errors, status: :unprocessable_entity
		end
	end

	# GET '/cart/items/1'	
	def view_cart_items
		order_order_id_resp = { order_id: 1 }.to_json
  	# UNComment(Haytham_Breaka)
  	# RestClient.get ORDERS_URL, {:params => {:user_id}}
  	order_id = JSON.parse( order_order_id_resp )

  	@cart_items = CartItem.where( order_id: order_id['order_id'] )

  	render json: @cart_items
  end

  # GET '/cart/old_items/1'
  def get_old_cart_items
  	@cart_items = CartItem.where( order_id: params['order_id'] )

  	render json: @cart_items
  end

	# DELETE /cart_items/1
	# DELETE /cart_items/1.json
	def destroy
		@cart_item.destroy

		head :no_content
	end

	def remove_item
		cart_item = get_item_where( order_id, item_id )
		#todo(Haytham_Breaka): check existence of items in cart.
		CartItem..destroy( cart_item['cart_items'][0]['id'] )
		render :json => {:remove_item_status => 'removed successfully'}
	end

  # post /cart/add_item
  def add_item
  	order_order_id_resp = RestClient.get ORDERS_URL + '/get_order', {:params => {:user_id => params['user_id']}}
  	#todo(Haytham_Breaka): check response.
  	order_id = JSON.parse( order_order_id_resp )
    
    store_query_resp = RestClient.get STORE_URL + '/query', {:params => {:item_id => params['item_id'], :quantity => params['quantity']}}
		#todo(Haytham_Breaka): check response.
    store_query_data = JSON.parse( store_query_resp )
      
    if store_query_data['enough_quantity'] && store_query_data['enough_quantity'] == true  
      cart_items_resp = get_item_where( order_id['order_id'], params['item_id'] )
       # todo(Haytham_Breaka): check response.
      cart_item_data = JSON.parse( cart_items_resp )
      
      if cart_item_data['found'] == true
      	cart_item = CartItem.new( cart_item_data['cart_items'][0] )
      	new_quantity = Integer( cart_item.quantity ) + Integer( params['quantity'] )
        update_with_param cart_item.id, new_quantity
      else
        CartItem.create( :item_id => params['item_id'], :quantity => params['quantity'], :price => params['price'], :order_id => order_id['order_id'])
      end
 
      render :json => {:cart_item_status => 'Item added to cart successfully'}
    else
    	render :json => {:cart_item_status => 'No enough items in store'}
    end
  end

private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity, :price, :order_id)
  end

  def update_with_param( id, quantity )
  	u = CartItem.find( id )
		if u.update( quantity: quantity )
		 ret = 'Record Updated'
		else
		 ret = 'Failed to update record'
		end
	end 

	def get_item_where( order_id, item_id )
		home_cart_items = CartItem.where( order_id: order_id, item_id: item_id )
    if home_cart_items.empty?
    	ret = { :found => false }.to_json
    else
    	ret = { :cart_items => home_cart_items, :found => true }.to_json
  	end
  end
end
