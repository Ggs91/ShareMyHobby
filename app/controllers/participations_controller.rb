class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_access_to_administrator, only: [:index, :destroy]

  def index
    @participations = Event.find(params[:id]).participants
  end

  def create
    Participation.create(user: current_user, event: Event.find(params[:id]))
  end

private

  def restrict_access_to_administrator
    redirect_to root_path, notice: "Action can't be performed, you are not the event's admin" unless current_user == Event.find(params[:id]).administrator
  end
end
