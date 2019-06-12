class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #Callbacks
  before_save :default_values
  #after_create :welcome_send

  #Associations
  belongs_to :department
  has_many :administrated_events, foreign_key: 'administrator_id', class_name: "Event", dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :attended_events, through: :participations, source: :event, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  #Validations
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: ": Please enter a valid email format" }  #phone number format also accepts 'N/A', in case it's been set as default value at registration time and not changed when updating
#  validates :phone_number, format: { :allow_blank => true, with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})|N\/A\z/, message: "Please enter a valid number (french format)" }
  validates :department, presence: {:message => ": Please choose a department" }
  validates :first_name, presence: true
  validates :last_name, presence: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def age  #calculate a user age based on it's date_ob_birth attribute. Set to N/A if no date submitting
    self.date_of_birth.nil? ? "N/A" : ((Time.zone.now - self.date_of_birth.to_time) / 1.year.seconds).floor
  end

  private

  def default_values   # set default values for fields left blank when submitting
    self.phone_number = "N/A" if self.phone_number.blank?
    self.description = "No description available" if self.description.blank?
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
