class StreamController < ApplicationController
  def show
  	response = RestClient.get STORE_URL+'items', {:params => {:count => 10}}
  	@item_array = JSON.parse response
  end

  def add_to_cart
  	RestClient.post CART_URL+'add_item', {:user_id => params[:user_id], :item_id => params[:item_id], :quantity => params[:quantity], :price => params[:price]}
  	#if response.code != 200
  	#	response_data = JSON.parse response
  	#	if response_data["in_stock"] && response_data["in_stock"] == true
  	respond_to do |format|
  		format.html { redirect_to STREAM_URL+'show', notice: 'Added to Cart' }
    end
  	#	end
  	#end
  end

end
