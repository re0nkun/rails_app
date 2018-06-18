class RelationMailer < ApplicationMailer
  def follow_notice(followed, follower)
    @followed = followed
    @follower = follower
    mail to: @followed.email, subject: "#{@follower.name} started following you"
  end
  def unfollow_notice(followed, follower)
    @followed = followed
    @follower = follower
    mail to: @followed.email, subject: "#{@follower.name} unfollowed you"
  end
end
