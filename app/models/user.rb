class User < ApplicationRecord
  # Deviseという認証機能を使うための設定
  # データベース認証、新規登録、パスワード回復、ログイン状態の保持、バリデーション機能を使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 1人のユーザーは複数のツイートを投稿できます
  has_many :tweets
  
  # 1人のユーザーは複数のコメントを投稿できます
  has_many :comments
  
  # ニックネームは必ず入力する必要があり、最大6文字までです
  validates :nickname, presence: true, length: { maximum: 6 }
end