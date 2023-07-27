class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  # validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def latest_posts
    posts.last(3).reverse
  end

  def posts_counter
    posts.count
  end

  def admin?
    role == 'admin'
  end
end
