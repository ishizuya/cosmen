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
  end

  def save
    @user = User.find(current_user.id)
    params[:user][:diagnosis] ? @user.diagnosis = params[:user][:diagnosis].join("") : false
    if @user.update(user_params)
      flash[:notice] = "診断が完了しました"
      redirect_to result_path(@user.id)
    else
      redirect_to :action => "diagnosis"
    end
  end

  protected
  def user_params
    params.require(:user).permit(:name, :age, :email, :sex, :skin_type, :diagnosis)
  end
end
