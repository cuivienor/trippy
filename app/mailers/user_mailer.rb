require 'mail'

class UserMailer < ApplicationMailer
    default from: 'gaproject3api@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your itinery with Trippy')
  end
end

# Call by running: UserMailer.deliver_now