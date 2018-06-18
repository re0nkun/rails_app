# Preview all emails at http://localhost:3000/rails/mailers/relation_mailer
class RelationMailerPreview < ActionMailer::Preview
  def follow_notice
    followed = User.first
    follower = User.second
    RelationMailer.follow_notice(followed, follower)
  end

  def unfollow_notice
    followed = User.first
    follower = User.second
    RelationMailer.unfollow_notice(followed, follower)
  end
end
