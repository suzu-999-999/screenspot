class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :comments, dependent: :destroy
  has_many :tweets, dependent: :destroy
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
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
