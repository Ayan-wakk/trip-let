class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    current_user.likes.find_or_create_by(post: @post)
    @show_count = on_show_page?
  end

  def destroy
    current_user.likes.find_by(post: @post)&.destroy
    @show_count = on_show_page?
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def on_show_page?
    request.referer&.include?(post_path(@post))
  end
end
