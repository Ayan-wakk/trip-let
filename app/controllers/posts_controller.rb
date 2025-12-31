class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.where(is_public: true)
                 .order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])

    unless @post.is_public? || @post.user == current_user # 投稿が公開されているまたは投稿者本人であるこのどちらでもない場合
      redirect_to posts_path, alert: "この投稿は非公開です"
    end
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
      redirect_to posts_path, notice: "投稿を作成しました"
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
      :visited_at, :warning, :is_public, images: [])
  end
end
