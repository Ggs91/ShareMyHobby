class UserMailer < ApplicationMailer
  default from: 'testapisandapplications@gmail.com'

  def welcome_email(user)
    #WE get the user instance and send it to the view "welcome_email"
    @user = user

    #This is the variable that would be use inside the email as a shortcut to our website.
    #The user just need to clik on the link to be redirect to our website
    @url  = 'https://share-my-hobby-production.herokuapp.com/users/sign_in'

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

end
