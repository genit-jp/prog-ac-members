require 'twitter'

Twitter.configure do |config|
  config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
  config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
  config.oauth_token = Rails.application.credentials.twitter[:oauth_token]
  config.oauth_token_secret = Rails.application.credentials.twitter[:oauth_token_secret]
end