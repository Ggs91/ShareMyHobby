class LikesController < ApplicationController
  #include LikesHelper
  before_action :set_event
  before_action :set_like, only: [:destroy]

  def create
    if already_liked?
      flash[:error] = "You can't like twice"
    else
      @event.likes.create(user: current_user)
      redirect_to root_path
    end
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
  redirect_to root_path
  end

private

  def set_like
    @like = @event.likes.find(params[:like_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def already_liked?
    Like.where(user: current_user, event: params[:id]).exists?
  end
end
