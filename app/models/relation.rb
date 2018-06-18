class Relation < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def self.send_follow_email(followed, follower)
    RelationMailer.follow_notice(followed, follower).deliver
  end
  def self.send_unfollow_email(followed, follower)
    RelationMailer.unfollow_notice(followed, follower).deliver
  end
end
