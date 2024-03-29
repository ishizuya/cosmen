class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   @item = Item.find(params[:item_id])
  #   @favorite = current_user.favorites.new(item_id: @item.id)
  #   @favorite.save
  #   redirect_to item_path(@item)
  # end

  # def destroy
  #   @item = Item.find(params[:item_id])
  #   @favorite = current_user.favorites.find_by(item_id: item.id)
  #   @favorite.destroy
  #   redirect_to item_path(@item)
  # end

  def create
    @item = Item.find(params[:item_id])
    @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
  end

  def destroy
    @item = Item.find(params[:item_id])
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    @favorite.destroy
  end

  protected
  def favorite_params
    params.require(:favorite).permit(:item_id)
  end
end
