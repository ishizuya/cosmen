class Public::UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def diagnosis
  end

  def result
  end

  def save
  end

  def user_params
    params.require(:user).permit(:name, :age, :email, :sex, :skin_type, :diagnosis)
  end
end
