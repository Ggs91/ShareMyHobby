class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_action :restrict_access_to_current_user, only: [:edit, :update, :destroy]

	def index
		@events = Event.all.order('start_date') # sart_date: :desc ??
	end

	def new
		@event = Event.new
	end

	def create                          #adds start_date attribute to the events params and associate the current user to the event being created
		@event = Event.new(event_params.merge(start_date: start_date_and_time, administrator: current_user))
		if @event.save
			flash[:success] = "Event Successfully Created !"
			redirect_to @event
		else
			flash[:danger] = "Oups, your event hasn't been created"
			render :new
		end
	end

	def show
		@event = set_event
		@comment = Comment.new
		@comments = @event.comments.order("created_at DESC") #comments will appear on descending order (the last comment will be the first etc..)
	end

	def edit
		@event = set_event
	end

	def update
		@event = set_event
		if @event.update(event_params.merge(start_date: start_date_and_time))
				flash[:success] = "Your modifications have been saved successfully"
				redirect_to @event
			else
				flash[:error] = "Your modifications haven't been saved"
				render :edit
			end
	end

	def destroy
		@event.destroy
		redirect_to event_path
	end


private

  def set_event
    @event = Event.find(params[:id])
  end

	def restrict_access_to_current_user  #check if the event subject of the action (thanks to its id in params) is owned by the current user, redirect to root_path otherwise
		redirect_to root_path, notice: "Action can't be perform, you are not the owner" unless current_user.id == set_event.administrator.id
	end

  def event_params
    params.require(:event).permit(:title, :description, :duration, :location, :category_id, :department_id, :max_participants)
	end

	def start_date_and_time
		date = params.require(:event).permit(:start_date)
		time = params.permit(:time)							#construction of full event's starting time (date + time) by parsing them through DateTime()
		DateTime.parse("#{date} #{time}")       #after getting each one separatly through the form
	end

end
