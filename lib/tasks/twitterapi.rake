namespace :twitterapi do
  desc "TODO"
  task read_feeds: :environment do

    twilio_account_sid = TWILIO_CONFIG['account_sid']
    twilio_auth_token = TWILIO_CONFIG['auth_token']
    twilio_client = Twilio::REST::Client.new twilio_account_sid, twilio_auth_token

    for i in Alert.all
      if i.user.twitter_account != nil
        twitter_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = TWITTER_CONFIG['consumer_key']
          config.consumer_secret     = TWITTER_CONFIG['consumer_secret']
          config.access_token        = i.user.twitter_account.token
          config.access_token_secret = i.user.twitter_account.secret
        end
      else
        twitter_client = Twitter::REST::Client.new do |config|
          config.consumer_key    = TWITTER_CONFIG['consumer_key']
          config.consumer_secret = TWITTER_CONFIG['consumer_secret']
          config.bearer_token    = TWITTER_CONFIG['bearer_token']
        end
      end
      if i.last_tweet_read == nil
        tweets = twitter_client.user_timeline(i.feed_username)
      else
        tweets = twitter_client.user_timeline(i.feed_username, since_id: i.last_tweet_read)
      end
      for tweet in tweets
        for keyword in i.keywords
          if tweet.text.downcase.match(keyword.phrase.downcase).present?
            if i.sms_enabled
              number = "+1" + i.user.sms_number.to_s
              message = twilio_client.account.sms.messages.create(:body =>
                (i.feed_username + " says: " + tweet.text).truncate(160),
                :to => number,
                :from => TWILIO_CONFIG['phone_number'])
            end
            if i.email_enabled
              UserMailer.alert(i.user, i, tweet).deliver
            end
          end
        end
      end
      if tweets.empty? == false
        updatedrecord = Alert.find(i.id)
        updatedrecord.last_tweet_read = tweets[0].id
        updatedrecord.save
      end
    end
  end
end
