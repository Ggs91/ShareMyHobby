class LikesController < ApplicationController
  before_action :set_event
  before_action :set_like, only: [:destroy]

  def create
    @event.likes.create(user: current_user)
    redirect_to root_path
  end

  def destroy
    @like.destroy
    redirect_to root_path
  end

private

  def set_like
    @like = @event.likes.find(params[:like_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
