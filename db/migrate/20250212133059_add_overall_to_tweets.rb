class AddOverallToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :overall, :integer
  end
end
