class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  def self.model_name 
    ActiveModel::Name.new(self, nil, "Tweet") 
  end
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_tweets, through: :bookmarks, source: :tweet
  def own?(object)
    id == object.user_id
  end

  def bookmark?(tweet)
    bookmarks.exists?(tweet_id: tweet.id)
  end

  def bookmark(tweet)
    bookmarks.create(user_id: id, tweet_id: tweet.id) unless bookmark?(tweet)
  end  

  def unbookmark(tweet)
    bookmarks.find_by(tweet_id: tweet.id)&.destroy
  end
end
