class Admin::HomesController < ApplicationController
  def top
    @user = User.all
  end
end
