class ItemReviewsController < ApplicationController
  before_action :set_item_review, only: [:show, :update, :destroy]

  # GET /item_reviews
  # GET /item_reviews.json
  def index
    @item_reviews = ItemReview.all

    render json: @item_reviews
  end

  # GET /item_reviews/1
  # GET /item_reviews/1.json
  def show
    render json: @item_review
  end

  # POST /item_reviews
  # POST /item_reviews.json
  def create
    @item_review = ItemReview.new(item_review_params)

    if @item_review.save
      render json: @item_review, status: :created, location: @item_review
    else
      render json: @item_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_reviews/1
  # PATCH/PUT /item_reviews/1.json
  def update
    @item_review = ItemReview.find(params[:id])

    if @item_review.update(item_review_params)
      head :no_content
    else
      render json: @item_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_reviews/1
  # DELETE /item_reviews/1.json
  def destroy
    @item_review.destroy

    head :no_content
  end

  private

    def set_item_review
      @item_review = ItemReview.find(params[:id])
    end

    def item_review_params
      params.require(:item_review).permit(:item_id, :user_id, :body, :rating)
    end
end
