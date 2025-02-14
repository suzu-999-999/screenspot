class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  def self.model_name 
    ActiveModel::Name.new(self, nil, "Tweet") 
  end
  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy
end
