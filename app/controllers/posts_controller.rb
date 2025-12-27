class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index # 投稿一覧ページ（誰でも見れる）
    @posts = Post.all
  end

  def show
    # 投稿詳細（ログイン必須）
  end

  def new
    @post = Post.new
  end

  def edit
    # 投稿編集（ログイン必須）
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "投稿を作成しました"
    else
      render :new
    end
    
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private
  
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, :body, :country, :region,
      :visited_at, :warning, :is_public, images:[])
  end
end
