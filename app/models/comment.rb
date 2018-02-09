class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  scope :by_time, ->{ order(created_at: :desc)}

end
