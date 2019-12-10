class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Your account was successfully created :)'
      redirect_to @user
    else
     render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success]='Your Profile has been successfully Updated!'
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
end










