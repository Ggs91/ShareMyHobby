class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :body, presence: true, allow_blank: false

  def creation_date
    self.created_at.strftime("%-d %B %Y - %H:%M")
  end

  def commenter_full_name
    self.user.first_name + " " + self.user.last_name
  end
end
