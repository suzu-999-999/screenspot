class AddGenreToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :genre, :string
  end
end
