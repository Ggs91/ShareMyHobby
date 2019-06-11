class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_access_to_administrator, only: [:index]
  before_action :set_event, only: [:index, :create, :destroy]

  def index
    @participations = set_event.participants
    @event = set_event
  end

  def create
    Participation.create(user: current_user, event: set_event)
    flash[:success] = "You're now part of this event !"
    redirect_to set_event
  end

  def destroy
    Participation.find_by(user: current_user, event: set_event).destroy
		flash[:notice] = "Participation canceled successfully"
		redirect_to set_event
  end

private

  def set_event
    Event.find(params.require(:id))
  end

  def restrict_access_to_administrator
    redirect_to root_path, notice: "Action can't be performed, you are not the event's admin" unless current_user == Event.find(params[:id]).administrator
  end
end
