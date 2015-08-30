class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # TODO Add validation for duplicate things!
    User.create(user_params)
    flash[:notice] = "User Successfully Created"
    flash[:username] = user_params[:username]
    redirect_to sessions_path
  end

    def show
        @user = User.first
        @user_id = @user.id
    end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :first_name, :first_name, :last_name, :password)
  end
  
end

