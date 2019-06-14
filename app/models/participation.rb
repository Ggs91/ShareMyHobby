class Participation < ApplicationRecord
  #Validations
  validates_with MaximumParticipationsValidator
  validates_with UniqueParticipationValidator

  #Associations
  belongs_to :user
  belongs_to :event

  #Callbacks
  after_create :user_participation_mail_send
  after_create :admin_registration_send


  private

  def user_participation_mail_send
    UserMailer.participation_email(self).deliver_now
  end

  def admin_registration_send
    UserMailer.admin_registration_email(self).deliver_now
  end
end
