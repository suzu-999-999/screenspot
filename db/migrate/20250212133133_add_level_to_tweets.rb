class AddLevelToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :level, :integer
  end
end
