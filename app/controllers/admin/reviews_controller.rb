class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reviews = Review.all.order(id: "DESC")
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
