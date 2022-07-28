class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.where(item_id: @item.id)
  end

  def ranking
    #@reviews = Review.all
    @items = Item.all.sort_by{|item| item.review_sort_value*-1 }
    #@items = Item.joins(:reviews).group(:item_id).order('count(whitening + wrinkle + moisturizing + acne_cure + no_irritation) desc')
    #@items = Item.left_joins(:reviews).distinct.sort_by(item.review.avg_reviews)
    #@itmes = Item.joins(:reviews).group(:item_id).order(wrinkle: :desc)
  end

  def search
    @items = Item.all
    @keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
    @keywords.each_with_index do |keyword, i|
      @result_items = Item.search(keyword) if i == 0
      @result_items = @result_items.merge(@result_items.search(keyword))
    end
    render "index"
  end

  protected
  def item_params
    params.require(:item).permit(:keyword)
  end
end