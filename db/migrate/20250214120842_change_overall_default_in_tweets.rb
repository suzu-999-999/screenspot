class ChangeOverallDefaultInTweets < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tweets, :overall, 3
  end
end
