class AddPlatformsToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :platforms, :string
  end
end
