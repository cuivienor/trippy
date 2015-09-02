require 'google'

class WelcomeController < ApplicationController

  include Google
  
  def index
  end

  def search
    code = getTickets(params[:location])
    response = getLocation(params[:location])
  end

end
