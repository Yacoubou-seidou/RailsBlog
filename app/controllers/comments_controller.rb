class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comments = Comment.includes(:user)
  end

  def new
    @comment = Comment.new
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def destroy
    @comment.destroy
    redirect_to request.referrer, notice: 'Your comment was successfully deleted!'
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to "/users/#{@user.id}/posts"
    else
      render 'posts/show'
    end
  end
end
