class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
    #@user = current_user
  end

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to item_path(@item.id)
    else
      render 'new'
    end
  end

  def index
    @reviews = Review.where(user_id: current_user.id).order(created_at: :desc)
    @reviews_count = @reviews.count
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(6)
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      redirect_to reviews_path
    end
  end

  private
  def review_params
    params.require(:review).permit(:user_id,:item_id,:wrinkle,:whitening,:moisturizing,:acne_cure,:no_irritation,:comment)
  end
end
