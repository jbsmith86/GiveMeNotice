class Alert < ActiveRecord::Base
  belongs_to :user
  has_many :keywords
  accepts_nested_attributes_for :keywords, allow_destroy: true
  validates :name, presence: true
  validates :feed_username, presence: true
end
