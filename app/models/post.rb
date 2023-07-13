class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_destroy :update_post_counter
  after_create :update_post_counter

  def update_post_counter
    author.posts_counter = author.posts.count
    author.save
  end

  def most_recent_comments
    comments.last(5)
  end
end
