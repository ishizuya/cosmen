class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
    #@user = current_user
  end

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました'
      redirect_to item_path(@item.id)
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def review_params
    params.require(:review).permit(:user_id,:item_id,:wrinkle,:whitening,:moisturizing,:acne_cure,:no_irritation,:comment)
  end
end
