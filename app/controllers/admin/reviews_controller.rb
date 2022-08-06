class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = '削除しました'
    redirect_to reviews_path
  end
end
