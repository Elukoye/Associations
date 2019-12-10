class EventsController < ApplicationController
    before_action :logged_in?, only: [ :new, :create, :edit, :update, :destroy]
	before_action :find_event, only: [:show, :edit, :update,  :destroy]

	def index
		@events = Event.all.paginate(page: params[:page])
		#@events_upcoming = Event.upcoming.paginate(page: params[:upcoming])
		#@events_past = Event.past.paginate(page: params[:past])
	end

	def new
		@event = current_user.events.build
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash.now[:success] = "Your event was created successfully."
			redirect_to event_path(@event)
		else
			render 'new'
		end
	end

	def show
		# Uses find_event method
	end

	def edit
		# Uses find_event method
	end

	def update
		if @event.update(event_params)
			flash[:success] = "Your event was updated successfully"
			redirect_to @event
		else
			render 'new'
		end
	end

	def destroy
		@event.destroy
		flash[:danger] = "Your event was DELETED successfully!"
		redirect_to root_path
	end

	private

		def find_event
			@event = Event.find(params[:id])
		end

		def event_params
			params.require(:event).permit(:title, :description, :location, :date )
		end


end
