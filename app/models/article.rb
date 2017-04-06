class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4 }
  validates :description, presence: true, length: { minimum: 6 }

  belongs_to :user
  validates :user_id, presence: true
end
