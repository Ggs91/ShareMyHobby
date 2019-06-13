class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  #This is going to be the user_id that we need to follow/unfollow. No relationship will be create without it.
  validates :follower_id , presence: true
  validates :followed_id , presence: true
end
