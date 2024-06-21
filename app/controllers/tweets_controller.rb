class TweetsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sentiment]  # Add this line to avoid CSRF verification issues with AJAX

  def index
    @tweets = Tweet.includes(:user).order('created_at DESC')
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.sentiment_score = SentimentAnalyzer.analyze(@tweet.text)
    if @tweet.sentiment_score < 0
      flash[:alert] = "ポジティブなツイートのみ投稿できます。"
      render :new
    elsif @tweet.save
      redirect_to root_path
      flash[:notice] = "ツイートを送信しました。"
    else
      flash[:alert] = "ツイートに失敗しました。"
      render :new
    end
  end

  def sentiment
    score = SentimentAnalyzer.analyze(params[:text])
    render json: { score: score }
  end
  
  private

  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end
end
