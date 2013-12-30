class User < ActiveRecord::Base
  has_one :twitter_account
  has_many :alerts
  validates :email, presence: true, uniqueness: true
  validates :sms_number, numericality: true, length: { minimum: 10, maximum: 10 }
  has_secure_password
  before_validation :fix_phone

  def fix_phone
    self.sms_number = self.sms_number.gsub(/\D/, '')
  end
end
