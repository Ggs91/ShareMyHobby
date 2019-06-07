class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #Callbacks
  before_save :default_values
  #Associations
  belongs_to :department
  has_many :administrated_events, foreign_key: 'administrator_id', class_name: "Event", dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :attended_events, through: :participations, source: :event, dependent: :destroy
  has_one_attached :profil_picture, dependent: :destroy
  #Validations
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: ": Please enter a valid email format" }
  validates :phone_number, format: { :allow_blank => true, with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "Please enter a valid number (french format)" }
  validates :department, presence: {:message => ": Please choose a department" }
  validates :first_name, presence: true
  validates :last_name, presence: true

private

  def default_values   # set default values for user's attributes that hasn't been submitted
    self.phone_number = "N/A" if self.phone_number.blank?
    self.age = "N/A" if self.age.blank?
    self.description = "No description available" if self.description.blank?
  end
end
