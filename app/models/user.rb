class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, # データーベースでのパスワード認証
         :registerable, #ユーザー登録
         :recoverable, # パスワードリセット
         :rememberable, # ログイン情報の記憶
         :validatable, # メール・パスワードのバリデーション
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter2] # Google, Twitter での OAuth 認証
end
