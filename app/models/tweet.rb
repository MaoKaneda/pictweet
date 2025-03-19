class Tweet < ApplicationRecord
  # ツイートのテキストは必ず入力する必要があります
  validates :text, presence: true
  
  # ツイートは1人のユーザーに属しています（誰が投稿したか）
  belongs_to :user
  
  # 1つのツイートには複数のコメントがつけられます
  has_many :comments

  # ツイートを検索するためのメソッド
  def self.search(search)
    # 検索キーワードが入力されている場合
    if search != ""
      # ツイートのテキストの中から検索キーワードを含むものを探します
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      # 検索キーワードが空の場合は全てのツイートを表示します
      Tweet.all
    end
  end
end