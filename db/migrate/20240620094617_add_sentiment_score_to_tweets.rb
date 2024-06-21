class AddSentimentScoreToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :sentiment_score, :integer
  end
end
