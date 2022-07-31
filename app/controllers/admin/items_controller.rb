class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def index
    @genres = Genre.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = '更新しました'
      redirect_to admin_item_path(@item)
    else
      render 'edit'
    end
  end

  def search
    @genres = Genre.all
    @items = Item.all
    # .page(params[:page]).per(12)
    if params[:keyword].present?
      @keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      @keywords.each_with_index do |keyword, i|
        # @items = @items.search(keyword) if i == 0
        @items = @items.merge(@items.search(keyword))
      end
      if params[:genre_id].present?
        @genre = Genre.find(params[:genre_id])
        @items = @items.select{ |item| item.genre_id == @genre.id }
      end
    else
      if params[:genre_id].present?
        @genre = Genre.find(params[:genre_id])
        @items = @items.select{ |item| item.genre_id == @genre.id }
      end
    end
    render "index"
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = '削除しました'
    redirect_to admin_items_path
  end

  private
    def item_params
      params.require(:item).permit(:brand, :name, :item, :image, :genre_id, :price, :capacity, :release_date, :introduction)
    end
end
