class UsersController < ApplicationController
  skip_before_action :require_login, only: [:show, :new, :create]



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
    @logged_in = logged_in? && @user_id
    if logged_in?
      @trips = User.find_by(id: params[:id]).trips
    end


  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :first_name, :first_name, :last_name, :password, :password_confirmation)
  end
  
end

