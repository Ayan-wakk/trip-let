class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
   # 投稿一覧ページ（誰でも見れる）
  end

  def show
    # 投稿詳細（ログイン必須）
  end

  def new
    # 投稿作成（ログイン必須）
  end

  def edit
    # 投稿編集（ログイン必須）
  end

  def create
    # 投稿作成処理（ログイン必須）
  end

  def update
    # 投稿更新処理（ログイン必須）
  end

  def destroy
    # 投稿削除（ログイン必須）
  end
end
