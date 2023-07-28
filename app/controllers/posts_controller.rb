class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 10)
  end

  def show
    @current_user = current_user
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
    @current_user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.author), notice: 'Post deleted successfully'
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end
end
