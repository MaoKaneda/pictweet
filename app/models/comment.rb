class Comment < ApplicationRecord
  # コメントは1つのツイートに属しています（どのツイートへのコメントか）
  belongs_to :tweet
  
  # コメントは1人のユーザーに属しています（誰がコメントしたか）
  belongs_to :user
end