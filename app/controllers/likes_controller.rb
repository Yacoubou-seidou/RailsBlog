class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user: @user, post: @post)
    return unless @like.save

    redirect_to user_posts_path(@user, @post)
  end
end
