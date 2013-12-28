namespace :twitterapi do
  desc "TODO"
  task read_feeds: :environment do

    twilio_account_sid = TWILIO_CONFIG['account_sid']
    twilio_auth_token = TWILIO_CONFIG['auth_token']
    @client = Twilio::REST::Client.new twilio_account_sid, twilio_auth_token

    for i in Alert.all
      if i.user.twitter_account != nil
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = TWITTER_CONFIG['consumer_key']
          config.consumer_secret     = TWITTER_CONFIG['consumer_secret']
          config.access_token        = i.user.twitter_account.token
          config.access_token_secret = i.user.twitter_account.secret
        end
      else
        client = Twitter::REST::Client.new do |config|
          config.consumer_key    = TWITTER_CONFIG['consumer_key']
          config.consumer_secret = TWITTER_CONFIG['consumer_secret']
          config.bearer_token    = TWITTER_CONFIG['bearer_token']
        end
      end

      tweets = client.user_timeline(i.feed_username)
      for tweet in tweets
        for keyword in i.keywords
          if tweet.text.downcase.includes?(keyword.phrase.downcase)
            if i.sms_enabled
              message = @client.account.sms.messages.create(:body => "Alert from twitter " +
                i.feed_username + " - " + tweet,
                :to => "+1" + i.user.sms_number,
                :from => TWILIO_CONFIG['phone_number'])
              puts message.sid
            end
            if i.email_enabled
              #mailer code
            end
          end
        end
      end
    end
  end
end
