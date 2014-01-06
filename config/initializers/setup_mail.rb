ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => GOOGLE_APPS_CONFIG['domain'],
  :user_name            => GOOGLE_APPS_CONFIG['username'],
  :password             => GOOGLE_APPS_CONFIG['password'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}