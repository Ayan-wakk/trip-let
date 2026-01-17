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
    # ユーザーを探すか、新しく作る準備をする
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |u|
      u.email = auth.info.email
      u.name  = auth.info.name
      u.password = Devise.friendly_token[0, 20]
    end

    # 新規登録ならメール確認をスキップ
    user.skip_confirmation! if user.new_record?

    # 保存を試み、失敗したらログに出す
    unless user.save
      Rails.logger.error "--------------------------------------------------"
      Rails.logger.error "Googleログイン保存失敗: #{user.errors.full_messages.join(', ')}"
      Rails.logger.error "--------------------------------------------------"
    end

    user # 最後にuserを返してあげる必要があります
  end
end
