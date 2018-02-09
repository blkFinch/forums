class Article < ApplicationRecord
  belongs_to :user
  scope :by_time, ->{ order(created_at: :desc)}
  validates :user_id, presence: true
  validates :body, presence: true 
  validates :title, presence: true
end
