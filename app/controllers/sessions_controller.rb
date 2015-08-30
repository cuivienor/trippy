class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: login_cred[:username]

    if user && user.authenticate(login_cred[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_sessions_path
    end
  end

  # Handles auto log in upon user creation
  def autoLogIn
    if flash[:notice] == "User Successfully Created"
      session[:user_id] = User.find_by(username: flash[:username]).id
    end
      redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_cred
    params.permit(:username, :password)
  end
end
