class EventController < ApplicationController

	def index
   		@event = Event.all
   	end 

  	def show
		@event = Event.find(params[:id])
  	end

  	def new
    	@event = Event.new
  	end

  	def edit
  	end

  	def create
   
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


end



