class TwitterController < ApplicationController
  protect_from_forgery except: [:slack]

  def fav
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter_prog_ac[:consumer_key]
      config.consumer_secret = Rails.application.credentials.twitter_prog_ac[:consumer_secret]
      config.oauth_token = Rails.application.credentials.twitter_prog_ac[:oauth_token]
      config.oauth_token_secret = Rails.application.credentials.twitter_prog_ac[:oauth_token_secret]
    end

    keywords = ['#駆け出しエンジニアと繋がりたい','#プログラミング初心者']
    for keyword in keywords do
      ids = Twitter.search(keyword, {:lang => 'ja', :count => 15}).map {|tweet| tweet.id }
      client.favorite(ids)
    end
    render json: { message: 'ok' }, :status => 200
  end

end
