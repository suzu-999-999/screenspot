class TweetsController < ApplicationController
  before_action :authenticate_user!
  
    def index
      @tweets = Tweet.all
    
      # キーワード検索
      if params[:search].present?
        @tweets = @tweets.where("body LIKE ?", "%#{params[:search]}%")
      end
    
      # タグ検索 (OR検索)
      if params[:tag_ids]
        selected_tag_names = params[:tag_ids].select { |_, v| v == "1" }.keys
        if selected_tag_names.any?
          @tweets = @tweets.joins(:tags).where(tags: { name: selected_tag_names }).distinct
        end
      end
    
      @tweets = @tweets.page(params[:page]).per(3)
    end
    
  
  def new
    @tweet = Tweet.new
  end
  def create
    puts "デバッグ: params = #{params.inspect}"
    tweet = Tweet.new(tweet_params)
    puts "デバッグ: tweet_params = #{@tweet.inspect}"
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
    
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  def bookmarks
    @tweets = current_user.bookmark_tweets
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :title, :name, :username, :overall, tag_ids: [],)
  end
end
