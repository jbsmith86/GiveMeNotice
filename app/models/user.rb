class User < ActiveRecord::Base
  has_one :twitter_account
end
