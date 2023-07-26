class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
  rescue StandardError
    flash[:error] = 'This user does not exist!'
    redirect_to root_path
  end
end
