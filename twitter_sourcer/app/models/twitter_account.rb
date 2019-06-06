class TwitterAccount < ApplicationRecord
  belongs_to :follower, class_name: "TwitterAccount", optional: true
  has_many :friends, class_name: "TwitterAccount", foreign_key: "follower_id"
end
