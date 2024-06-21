require 'sentimental'

class SentimentAnalyzer
  def self.analyze(text)
    analyzer = Sentimental.new
    analyzer.load_defaults
    score = analyzer.score(text)
    (score * 100).to_i # スコアを-100から+100の範囲に変換
  end
end
