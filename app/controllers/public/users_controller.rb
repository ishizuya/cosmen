class Public::UsersController < ApplicationController

  def show
    @user = current_user
    #@user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to mypage_path(@user)
    else
      render 'edit'
    end
  end

  def index
    @reviews = current_user.reviews
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end

  def diagnosis
    @user = User.find(current_user.id)
  end

  def result
    @user = User.find(current_user.id)
    if @user.diagnosis == "1"
      @items = Item.all.sort_by{|item| item.avg_moisturizing*-1 }.first(5)
    elsif @user.diagnosis == "2"
      @items = Item.all.sort_by{|item| item.avg_whitening*-1 }.first(5)
    elsif @user.diagnosis == "3"
      @items = Item.all.sort_by{|item| item.avg_wrinkle*-1 }.first(5)
    elsif @user.diagnosis == "4"
      @items = Item.all.sort_by{|item| item.avg_acne_cure*-1 }.first(5)
    else
      @items = Item.all.sort_by{|item| item.avg_no_irritation*-1 }.first(5)
    end
  end


  def save
    @user = User.find(current_user.id)
    input = [params[:user][:question1],params[:user][:question2], params[:user][:question3], params[:user][:question4], params[:user][:question5]].join
    p input
    if input == "12222" or input == "11112" or input == "12112" or input == "11212" or input == "11122" or input == "12212" or input == "12122" or input == "11222" or input == "22222"
       @user.diagnosis = "1"
    elsif input ==  "21222"
       @user.diagnosis = "2"
    elsif input ==  "22122" or input == "21122"
      @user.diagnosis = "3"
    elsif input ==  "22212" or input == "21112" or input == "22112" or input == "21212"
      @user.diagnosis = "4"
    else
      @user.diagnosis = "5"
    end
    if @user.update(user_params)
      flash[:notice] = "診断が完了しました"
      redirect_to result_path
    else
      redirect_to :action => "diagnosis"
    end
  end

  protected
  def user_params
    params.require(:user).permit(:name, :age, :email, :sex, :skin_type, :diagnosis)
  end
end
