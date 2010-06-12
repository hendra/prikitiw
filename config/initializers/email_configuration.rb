ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "41studio.com",
  :authentication => :plain,
  :user_name => "do-not-reply@41studio.com",
  :password => "2626T9"
}