class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    post.likes_counter = post.likes.count
    post.save
  end

  after_create do
    update_likes_counter
  end

  after_destroy do
    update_likes_counter
  end
end
