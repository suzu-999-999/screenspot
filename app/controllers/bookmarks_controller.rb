class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
    def create
      @tweet = Tweet.find(params[:tweet_id])
      current_user.bookmark(@tweet)
      respond_to do |format|
        format.js   # create.js.erb をレンダリング
        format.html { redirect_to request.referer, notice: "ブックマークしました" }
      end
    end
  
    def destroy
      @tweet = Tweet.find(params[:tweet_id])
      current_user.unbookmark(@tweet)
      respond_to do |format|
        format.js   # destroy.js.erb をレンダリング
        format.html { redirect_to request.referer, notice: "ブックマークを解除しました" }
      end
    end
end
