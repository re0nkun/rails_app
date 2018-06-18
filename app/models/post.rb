class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :body, presence: true
  default_scope -> { order(created_at: :desc) }

  def liked_by? current_user
    # likes.include?(current_user.id)
    # likes.find_by(user_id: current_user.id)
    likes.where(user_id: current_user.id).exists?
  end
end
