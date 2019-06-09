class MaximumParticipationsValidator < ActiveModel::Validator
  def validate(record)
    if record.event.participants.count >= record.event.max_participants
      record.errors[:base] << "Maximum number of participations already reached"
    end
  end
end
