module LikesHelper
  def liked?(event)
    event.likes.find { |like| like.user_id == current_user.id }
  end
end
