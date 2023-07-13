class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  def latest_posts
    posts.last(3).reverse
  end
end
