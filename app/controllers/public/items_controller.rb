class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.where(item_id: @item.id)
  end

  def ranking
    @items = Item.all
    @reviews = Review.all
  end
end
