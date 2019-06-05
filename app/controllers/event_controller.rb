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
		#@event.category_id = params[:category_id] liste déroulante
		#@event.administrator_id = params[:administrator_id] = current user 
		#@event.department_id = params[:department_id]  liste déroulante
  		@event = Event.new(
			title: params[:title],
			description: params[:description],
			duration: params[:duration],
			location: params[:location],
			start_date: params[:start_date])
		if @event.save
			flash[:success] = 'Successfully create event !'
			redirect_to "/"
		else
			flash[:warning] = 'Oups'
			redirect_to "/"
		end
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



