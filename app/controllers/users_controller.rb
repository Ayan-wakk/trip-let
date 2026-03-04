class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    if current_user == @user
      @posts = @user.posts
    else
      @posts =  @user.posts.where(is_public: true)
    end

    @posts = @posts
             .includes(:user, images_attachments: :blob)
             .order(created_at: :desc)
             .page(params[:page])
             .per(20)
  end

  def likes
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts
                  .page(params[:page])
                  .per(20)
  end
end
