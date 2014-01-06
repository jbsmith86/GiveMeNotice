TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
TWILIO_CONFIG = YAML.load_file("#{::Rails.root}/config/twilio.yml")[::Rails.env]
GOOGLE_APPS_CONFIG = YAML.load_file("#{::Rails.root}/config/googleapps.yml")[::Rails.env]