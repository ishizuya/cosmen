class Public::ItemsController < ApplicationController

  def show
    @item = Item.where_genre_active.find(params[:id])
    @genres = Genre.all
    @reviews = Review.where(item_id: @item.id)
    @favorites = Favorite.where(item_id: @item.id)

  end

  def ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.review_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def whitening_ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.whitening_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def wrinkle_ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.wrinkle_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def moisturizing_ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.moisturizing_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def acne_cure_ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.acne_cure_*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def irritation_ranking
    @genres = Genre.all
    @all_ranks = Item.all.sort_by{|item| item.no_irritation_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @genre_ranks = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
  end

  def index
    @genres = Genre.all
    @items = Item.all
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

  protected
  def item_params
    params.require(:item).permit(:keyword, :genre_id)
  end
end