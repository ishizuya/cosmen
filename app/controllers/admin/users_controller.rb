class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to admin_top_path
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :sex, :age, :skin_type, :diagnosis, :is_deleted)
  end

end
