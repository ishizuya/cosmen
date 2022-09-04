class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all.order(id: "DESC")
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end
end
