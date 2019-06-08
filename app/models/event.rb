class Event < ApplicationRecord
  belongs_to :department
  belongs_to :category
  belongs_to :administrator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy

end
