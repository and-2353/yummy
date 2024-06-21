# app/models/tweet.rb
class Tweet < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  validates :sentiment_score, numericality: { greater_than_or_equal_to: -100, less_than_or_equal_to: 100 }

  before_save :set_sentiment_score

  private

  def set_sentiment_score
    self.sentiment_score = SentimentAnalyzer.analyze(self.text)
  end
end
