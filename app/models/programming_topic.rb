class Programming_Topic < ApplicationRecord
  has_many :articlesprogramming_topic
  has_many :articles, through: :articlesprogramming_topics
end
