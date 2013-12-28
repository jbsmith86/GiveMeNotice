class UserMailer < ActionMailer::Base
  default from: "donotreply@givemenotice.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.alert.subject
  #
  def alert(user, alert, tweet)
    @tweet = tweet
    @alert = alert
    mail to: user.email, subject "You have a new alert"
  end
end
