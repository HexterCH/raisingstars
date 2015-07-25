class UserMailer < ApplicationMailer
  default from: 'howclf@gmail.com'
  def welcome_email(user)
    @user = user
    @url = 'http://raisingstars.co/users/sign_in'
    mail(to: @user.email, subjec: 'Welcome to Raising Stars')
  end
end
