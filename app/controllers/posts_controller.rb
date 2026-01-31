class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :index, if: -> { params[:scope] == "my" }
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @is_my_page = params[:scope] == "my"

    base_posts =
      if @is_my_page
        current_user.posts
      else
        Post.where(is_public: true)
      end

    @q = base_posts.ransack(params[:q])

    @posts = @q
               .result
               .order(created_at: :desc)
               .page(params[:page])
               .per(20)
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

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "投稿を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:post][:remove_image_ids]
      params[:post][:remove_image_ids].reject(&:blank?).each do |id|
        @post.images.find(id).purge
      end
    end

    @post.images.attach(post_params[:images]) if post_params[:images].present?

    success = @post.update(post_params.except(:images))

    if success
      redirect_to @post, notice: "投稿を更新しました"
    else
      render :edit, status: :unprocessable_entity
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
