class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(release_date: :desc).limit(5)
  end
end
