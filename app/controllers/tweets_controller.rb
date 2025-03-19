class TweetsController < ApplicationController
  # ツイートの編集と表示の前に、対象のツイートを取得します
  before_action :set_tweet, only: [:edit, :show]
  # ログインしていないユーザーは、index、show、search以外のアクションにアクセスできません
  before_action :move_to_index, except: [:index, :show, :search]

  # ツイート一覧を表示する
  def index
    # ユーザー情報も一緒に取得して、最新の投稿順に表示します
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  # 新規ツイート投稿フォームを表示する
  def new
    @tweet = Tweet.new
  end

  # 新規ツイートを保存する
  def create
    Tweet.create(tweet_params)
    redirect_to '/'
  end

  # ツイートを削除する
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end

  # ツイート編集フォームを表示する
  def edit
  end

  # ツイートを更新する
  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to root_path
  end

  # ツイートの詳細を表示する
  def show
    # コメント投稿用の空のコメントオブジェクトを作成
    @comment = Comment.new
    # このツイートに付いているコメントを全て取得（ユーザー情報も一緒に）
    @comments = @tweet.comments.includes(:user)
  end

  # ツイートを検索する
  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  # ツイートのパラメータを安全に取得する
  def tweet_params
    # 画像とテキストのパラメータを許可し、現在ログインしているユーザーのIDも追加
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  # 対象のツイートを取得する
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # ログインしていないユーザーはトップページにリダイレクト
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end