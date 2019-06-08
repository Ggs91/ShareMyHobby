class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def index
		@events = Event.all.order("start_date") # sart_date: :desc ??
	end

	def new
		@event = Event.new
	end

	def create                          #adds start_date attribute to the events params and associating the current user to the event being created
		@event = Event.new(event_params.merge(start_date: start_date_and_time, administrator: current_user))
		if @event.save
			flash[:success] = 'Event Successfully Created !'
			redirect_to root_path
		else
			flash[:warning] = 'Oups, your event has not been created'
			render :new
		end
	end

	def show
		@event = set_event
		@comment = Comment.new
		@comments = @event.comments.order("created_at DESC") #comments will appear on descending order (the last comment will be the first etc..)
	end

	def edit
	end

	def update
		unless current_user == @event.administrator_id
		redirect_back fallback_location: root_path, notice: 'User is not owner'
		end
		@event.update(event_params)
		redirect_to events_path(@event.id)
	end

	def destroy
		@event.destroy
		redirect_to event_path
	end


private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :duration, :location, :category_id, :department_id, :max_participants)
	end

	def start_date_and_time #construction of full event's starting time (date + time) by parsing them through DateTime()
		date = params.require(:event).permit(:start_date)    #after getting each one separatly through the form
		time = params.permit(:time)
		DateTime.parse("#{date} #{time}")
	end

end
