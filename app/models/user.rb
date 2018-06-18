class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :active_rels, class_name: "Relation", foreign_key: :follower_id
  has_many :followeds, through: :active_rels
  has_many :passive_rels, class_name: "Relation", foreign_key: :followed_id
  has_many :followers, through: :passive_rels

  validates :name, presence: true

  # def followed_by? u
  #   self.passive_rels.where(follower_id: u.id).exists?
  # end

  def following? other_user
    self.followeds.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM relations
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})", user_id: id)
  end

end
