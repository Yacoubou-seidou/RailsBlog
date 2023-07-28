class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }

  def index
    user = User.find(params['user_id'])
    comments = user.comments
    render json: comments
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def create
    token = request.headers['X-Token']
    user = User.find_by(api_token: token)
    post = Post.find(params['post_id'])

    new_comment = post.comments.new(
      text: params['text'],
      user:
    )

    if new_comment.save
      render json: { success: 'Comment added successfully' }, status: :created
    else
      render json: { error: new_comment.errors.full_messages }, status: :bad_request
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_request
  end
end
