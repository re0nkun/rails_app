class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post_id: @post.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.likes.find_by(post_id: @post.id).destroy
    redirect_back(fallback_location: root_path)
  end
end
