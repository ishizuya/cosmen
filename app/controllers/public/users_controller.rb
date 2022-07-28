class Public::UsersController < ApplicationController
  def show
    @user = current_user
    #@reviews = Reviews.where(user_id: @user.id)
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

  def diagnosis
  end

  def result
  end

  def save
  end

  protected
  def user_params
    params.require(:user).permit(:name, :age, :email, :sex, :skin_type, :diagnosis)
  end
end
