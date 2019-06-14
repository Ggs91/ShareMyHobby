class UserMailer < ApplicationMailer
  default from: 'testapisandapplications@gmail.com'

  def welcome_email(user)
    #WE get the user instance and send it to the view "welcome_email"
    @user = user

    #This is the variable that would be use inside the email as a shortcut to our website.
    #The user just need to clik on the link to be redirect to our website
    @url  = "https://share-my-hobby-production.herokuapp.com"

    mail(to: @user.email, subject: 'Welcome to ShareMyHobby!')
  end

  def participation_email(participation)
    @participation = participation
    @user = @participation.user
    @event = @participation.event

    @url  = "https://share-my-hobby-production.herokuapp.com"
    mail(to: @user.email, subject: "You'registration is confirm to #{@event.title}")
  end

  def admin_registration_email(registration)
    @registration = registration
    @user = @registration.user
    @event = @registration.event
    @admin = @event.administrator

    @url = "https://share-my-hobby-production.herokuapp.com"
    mail(to: @admin.email, subject: "New registration")
  end

end
