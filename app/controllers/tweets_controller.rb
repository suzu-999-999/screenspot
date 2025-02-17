class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
   if params[:search] == nil
    @tweets = Tweet.all
    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|      
        @tweets += Tag.find_by(name: key).tweets if value == "1"
      end
      @tweets.uniq!
      if params[:tag]
        Tag.create(name: params[:tag])
      end
    end
   elsif params[:search] == ''
    @tweets= Tweet.all
   else
    @tweets = Tweet.where("body LIKE ? ",'%' + params[:search] + '%')
   end
   @tweets = Tweet.page(params[:page]).per(3)
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
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
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
    params.require(:tweet).permit(:body, :name, :username, :overall, tag_ids: [],)
  end
end
