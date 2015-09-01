class UsersController < ApplicationController

  def show
  end


  def new
    @user = User.new

  end

  def create
    # TODO Add validation for duplicate things!
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "User Successfully Created"
      flash[:username] = user_params[:username]
      redirect_to sessions_path
    else
      render new_user_path
    end

  end

  def show
    @user_id = params[:id]
    @logged_in = authorized?
    @trips = User.find_by(params[:user_id]).trips
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :first_name, :first_name, :last_name, :password, :password_confirmation)
  end
  
end

