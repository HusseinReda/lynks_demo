class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    if (params[:count])
      @items = Item.first(params[:count])
    end

    render json: @items
  end

  # GET /items/1
  # GET /items/1.json
  def show
    render json: @item
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    item = Item.find(params[:id])

    puts params[:consume]

    if params[:consume] 
      success = false
      item = Item.find(params[:id])
      #Item.transaction do
      #  lock!
      puts item.quantity
      if item.quantity != 0
        item.quantity -= 1
        item.save!
        sucess = true
      end
      #  save!
      #end
      render :json => {:success => success}
    end

    #if @item.update(item_params)
    #  head :no_content
    #else
    #  render json: @item.errors, status: :unprocessable_entity
    #end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy

    head :no_content
  end

  def query
    item = Item.find(params['item_id'])
    in_stock = false;
    if item
      if item.quantity > 0
        in_stock = true
      end
    end
    render :json => {:in_stock => in_stock}
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :price, :description, :quantity, :thumbnail, :category_id)
    end
end
