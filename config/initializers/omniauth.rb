Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_CONFIG['consumer_key'], TWITTER_CONFIG['consumer_secret']
end