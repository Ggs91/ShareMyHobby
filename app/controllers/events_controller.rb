class EventsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def index
		@events = Event.all.order("start_date") # sart_date: :desc ??
	end

	def new
		@event = Event.new
	end

	def create
		#@event.category_id = params[:category_id] liste déroulante
		#@event.department_id = params[:department_id]  liste déroulante
		@event = Event.new(
			title: params[:title],
			description: params[:description],
			duration: params[:duration],
			location: params[:location],
			start_date: params[:start_date]
		)
		@event.administrator_id = current_user
		if @event.save
		flash[:success] = 'Successfully create event !'
		redirect_to "/"
		else
		flash[:warning] = 'Oups'
		redirect_to "/"
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
    params.require(:event).permit( :title,  :description, :start_date, :duration, :location, :category, :department)
	end

end
