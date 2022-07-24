class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Reviews.all
  end

  def show
  end

  def destroy
  end
end
