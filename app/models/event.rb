class Event < ApplicationRecord
  #Associations
  belongs_to :department
  belongs_to :category
  belongs_to :administrator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  #Validations
  validate :start_date_cannot_be_in_the_past
  validate :positif_multiple_of_5
  validates :duration, numericality: { only_integer: true }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 5..1000 }
  validates :location, presence: true
  validates :department, presence: {:message => "must be selected" }
  validate :event_picture_limit_check

  #Scopes
  scope :ten_most_recent, -> { order(created_at: :desc).limit(10) }
  scope :five_random_selection, -> { reorder("RANDOM()").limit(5) }
  scope :in_department, -> (department) {where(department_id: department)}
  scope :in_categories, -> (categories) {where(category_id: categories)}

  #Pagination
  self.per_page = 6

  def number_of_places_available
    self.max_participants - self.participants.count
  end

  def has_place_available?
    self.number_of_places_available  > 0
  end

  def starting_date
    self.start_date.strftime("%d-%m-%Y") + " at " + self.start_date.strftime("%H:%M")
  end

  def has_participant?(user) #return true if the user passed as argument is participant
    self.participants.include?(user)
  end

  def is_administrated_by?(user)
    self.administrator == user
  end

  def administrator_full_name
    self.administrator.first_name + " " + self.administrator.last_name
  end

  def is_still_ongoing?
    DateTime.parse("#{self.start_date}") >= DateTime.now.change(offset: "+0000")
  end

private

  def start_date_cannot_be_in_the_past
     errors.add(:start_date, ": time and date must be present or can't be in the past") unless start_date.present? && DateTime.parse("#{start_date}") >= DateTime.now.change(offset: "+0000")
  end

  def positif_multiple_of_5
    errors.add(:duration, "must be a multiple of 5") unless duration.present? && duration > 0 && duration % 5 == 0
  end

  def event_picture_limit_check
    if picture.attached?
      if picture.blob.byte_size > 2000000
        picture.purge
        errors[:base] << "The picture should be smaller than 2Mo"
      end
    end
  end

end
