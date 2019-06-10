class UniqueParticipationValidator < ActiveModel::Validator
  def validate(record)
    user_requesting_for_participation = record.user
    if record.event.participants.include?(User.find(user_requesting_for_participation.id))
      record.errors[:base] << "User already participate at this event"
    end
  end
end
#Make sure a user can't participate twice to the same event
