class TwitterController < ApplicationController
  protect_from_forgery except: [:fav]

  def fav_prog_ac
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter_prog_ac[:consumer_key]
      config.consumer_secret = Rails.application.credentials.twitter_prog_ac[:consumer_secret]
      config.access_token = Rails.application.credentials.twitter_prog_ac[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter_prog_ac[:access_token_secret]
    end

    keywords = ['#プログラミング初心者']
    result = []
    for keyword in keywords do
      tweets = client.search(keyword, {:lang => 'ja', :count => 100/keywords.length, :result_type => 'recent' })
      result.push tweets.to_h[:statuses]
    end
    # すべてのツイートをcreated_atでソートする
    result.flatten!
    result.sort!{|a, b| b[:created_at] <=> a[:created_at] }
    ids = result.map{|tweet| tweet[:id] }
    ids.uniq!
    client.favorite(ids.take(40))

    render json: ids.to_json, :status => 200
  end

  def fav_genit
    hour = Time.current.hour
    logger.debug "#{hour}時"
    if hour < 6 or hour > 13 then
      render json: {message: 'cancel'}, :status => 200
      return
    end
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter_genit[:consumer_key]
      config.consumer_secret = Rails.application.credentials.twitter_genit[:consumer_secret]
      config.access_token = Rails.application.credentials.twitter_genit[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter_genit[:access_token_secret]
    end

    keywords = ['#今日の積み上げ ']
    result = []
    for keyword in keywords do
      tweets = client.search(keyword, {:lang => 'ja', :count => 50/keywords.length, :result_type => 'recent' })
      result.push tweets.to_h[:statuses]
    end
    # すべてのツイートをcreated_atでソートする
    result.flatten!
    result.sort!{|a, b| b[:created_at] <=> a[:created_at] }
    ids = result.map{|tweet| tweet[:id] }
    ids.uniq!
    client.favorite(ids.take(20))

    render json: ids.to_json, :status => 200
  end

end
