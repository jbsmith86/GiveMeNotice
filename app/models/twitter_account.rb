class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  has_many :alerts, through: :user
end
