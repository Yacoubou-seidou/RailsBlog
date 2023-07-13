class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_destroy :update_comment_counter
  after_create :update_comment_counter

  def update_comment_counter
    post.comments_counter = post.comments.count
    post.save
  end
end
