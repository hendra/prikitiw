class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject << 'Please activate your new account'
    @body[:url] = "http://#{AppConfig.site_url}/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject << 'Your account has been activated!'
    @body[:url] = "http://#{AppConfig.site_url}"
  end

  def forgot_password(password)
    setup_email(password.user)
    @subject << 'You have requested to change your password'
    @body[:url] = "#{AppConfig.site_url}/change_password/#{password.reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject << 'Your password has been reset.'
  end

  protected

  def setup_email(user)
    @recipients = "#{user.email}"
    @from = AppConfig.admin_email
    @subject = "[#{AppConfig.app_name}] "
    @sent_on = Time.now
    @body[:user] = user
  end
end
