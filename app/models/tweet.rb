class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  def self.model_name 
    ActiveModel::Name.new(self, nil, "Tweet") 
  end
end
