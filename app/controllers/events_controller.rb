class EventsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :find_event, :correct_user, only: %i[edit update destroy]

  def index
    @future_events = Event.future_events
    @past_events = Event.past_events
  end

  def new
   @event = current_user.events.build
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = 'Your event has been created.'
      redirect_to @event
    else
      render 'new'
    end
  end 
  
  def show
   #before-action :find_event
  end

  def edit
   #before-action :find_event
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = 'Your event has been updated.'
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = 'Event has been cancelled.'
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_time, :description)
  end

  def logged_in_user
    unless logged_in?
      flash[:info] = 'You must be logged in to do that.'
      redirect_to login_path
    end
  end

  def correct_user
    @user = Event.find(params[:id]).creator
    unless @user == current_user
      flash[:danger] = 'You are not authorized.'
      redirect_to root_path
    end
  end
  
  def find_event
    @event = Event.find(params[:id])
  end
end
