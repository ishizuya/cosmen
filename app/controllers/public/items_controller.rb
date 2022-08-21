class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :index, :show ]

  def show
    @item = Item.where_genre_active.find(params[:id])
    @genres = Genre.all
    @reviews = Review.where(item_id: @item.id).order(created_at: "DESC")
    @reviews_count = @reviews.count
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(6)
    @favorites = Favorite.where(item_id: @item.id)
  end

  def ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.review_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @items.select{ |item| item.genre_id == @genre.id }
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def whitening_ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.whitening_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @items.select{ |item| item.genre_id == @genre.id }.page(params[:page])
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def wrinkle_ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.wrinkle_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def moisturizing_ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.moisturizing_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def acne_cure_ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.acne_cure_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @items.select{ |item| item.genre_id == @genre.id }
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def irritation_ranking
    @genres = Genre.all
    @items = Item.all.sort_by{|item| item.no_irritation_sort_value*-1 }
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @all_ranks.select{ |item| item.genre_id == @genre.id }
    end
    @items = Kaminari.paginate_array(@items).page(params[:page])
    if params[:page].present?
      @ranking = params[:page].to_i*5-5
    else
      @ranking = 0
    end
  end

  def index
    @genres = Genre.all
    @items = Item.all
  end

  def search
    @genres = Genre.all
    @items = Item.all
    if params[:keyword].present?
      @keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      @keywords.each_with_index do |keyword, i|
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
    @items = @items.sort_by do |v|
      [v[:release_date].to_s]
    end
    @items = @items.reverse
    @items = Kaminari.paginate_array(@items).page(params[:page])
    render "index"
  end

  protected
  def item_params
    params.require(:item).permit(:name, :brand, :price, :capacity, :introduction, :release_date, :keyword, :genre_id)
  end
end