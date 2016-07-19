class StreamController < ApplicationController
  def show
  	response = RestClient.get 'http://localhost:3000/items/', {:params => {:count => 10}}
  	@item_array = JSON.parse response
  end

  def add_to_cart
  	RestClient.post 'http://localhost:3002/orders/add_item', {:user_id => params[:user_id], :item_id => params[:item_id], :quantity => params[:quantity], :price => params[:price]}
  	#if response.code != 200
  	#	response_data = JSON.parse response
  	#	if response_data["in_stock"] && response_data["in_stock"] == true
  	respond_to do |format|
  		format.html { redirect_to 'http://localhost:3003/stream/show', notice: 'Added to Cart' }
    end
  	#	end
  	#end
  end

end
