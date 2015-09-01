class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @user = User.new
    binding.pry
  end

  def create
    @user = User.create(user_params)
    binding.pry
    if @user.save
      flash[:notice] = "User Successfully Created"
      flash[:username] = user_params[:username]
      redirect_to sessions_path
    else
      redirect_to new_user_path
    end

  end

  def show
    @user_id = params[:id]
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :first_name, :first_name, :last_name, :password, :password_confirmation)
  end
  
end

