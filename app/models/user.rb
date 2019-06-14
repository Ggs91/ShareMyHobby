class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #Callbacks
  before_save :default_values
  after_create :welcome_send

  #Associations
  belongs_to :department
  has_many :administrated_events, foreign_key: 'administrator_id', class_name: "Event", dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :attended_events, through: :participations, source: :event, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy

  # A user can or can't have followers. We're using the Friendship table to join a follower to a user
  # who is identify by his id
  has_many :active_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy

  #Same as the follower relation. A user can decided to follow an other user.
  has_many :passive_friendships, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy

  # using following make more sense for the users that an other one follow because the word followers
  # is better for the users that follows an other one. We're using the active_friendships to found the user
  # to follow/unfollow
  has_many :following, through: :active_friendships, source: :followed

  #Same as the following relation but the opposite
  # For more clarity ze're using has_many :followers instead of :follower
  has_many :followers, through: :passive_friendships, source: :follower

  #Validations
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: ": Please enter a valid email format" }  #phone number format also accepts 'N/A', in case it's been set as default value at registration time and not changed when updating
  validates :phone_number, format: { :allow_blank => true, with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})|N\/A\z/, message: "Please enter a valid number (french format)" }
  validates :department, presence: {:message => ": Please choose a department" }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def age  #calculate a user age based on it's date_ob_birth attribute. Set to N/A if no date submitting
    self.date_of_birth.nil? ? "N/A" : ((Time.zone.now - self.date_of_birth.to_time) / 1.year.seconds).floor
  end

  def follow(user)
    active_friendships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_friendships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
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
