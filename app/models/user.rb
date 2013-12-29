class User < ActiveRecord::Base
  has_one :twitter_account
  has_many :alerts
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
