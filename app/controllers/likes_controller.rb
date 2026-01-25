class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    current_user.likes.create!(post: @post)
    redirect_to @post
  end

  def destroy
    current_user.likes.find_by(post: @post)&.destroy
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
