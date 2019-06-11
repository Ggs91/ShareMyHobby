class Participation < ApplicationRecord
  validates_with MaximumParticipationsValidator
  validates_with UniqueParticipationValidator
  belongs_to :user
  belongs_to :event
end
