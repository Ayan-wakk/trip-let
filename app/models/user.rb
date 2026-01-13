class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, # データーベースでのパスワード認証
         :registerable, # ユーザー登録
         :recoverable, # パスワードリセット
         :rememberable, # ログイン情報の記憶
         :validatable, # メール・パスワードのバリデーション
         :confirmable, # メールアドレス変更
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter2] # Google, Twitter での OAuth 認証

  has_many :posts, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name  = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end
