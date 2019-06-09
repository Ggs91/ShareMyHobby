class Event < ApplicationRecord
  #Associations
  belongs_to :department
  belongs_to :category
  belongs_to :administrator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  #Validations
  validate :start_date_cannot_be_in_the_past
  validate :positif_multiple_of_5
  validate :date_time_format
  validates :duration, numericality: { only_integer: true }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 5..1000 }
  validates :location, presence: true
  validates :department, presence: {:message => "must be selected" }

  def number_of_places_available
    self.max_participants - self.participants.count
  end

  def has_place_available? #return true if there's still place available
    self.number_of_places_available > self.participants.count
  end

  def end_date
    self.start_date + self.duration.minutes
  end

private

  def start_date_cannot_be_in_the_past
     errors.add(:start_date, "must be present or can't be in the past") unless start_date.present? && start_date >= DateTime.now
  end

  def positif_multiple_of_5
    errors.add(:duration, "must be a multiple of 5") unless duration.present? && duration > 0 && duration % 5 == 0
  end

  def date_time_format
    errors.add(:date_time, 'must be a valid. Choose a date and a time') if ((DateTime.parse(date_time) rescue ArgumentError) == ArgumentError)
  end
end
