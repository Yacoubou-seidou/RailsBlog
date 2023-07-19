class PostsController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.all
  end
end
