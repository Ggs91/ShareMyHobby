class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :department
  has_many :administrated_events, foreign_key: 'administrator_id', class_name: "Event", dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :attended_events, through: :participations, source: :event, dependent: :destroy
end
