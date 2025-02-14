class AddUsernameToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :username, :string
  end
end
