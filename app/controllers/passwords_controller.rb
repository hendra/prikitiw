class PasswordsController < ApplicationController
  require 'active_support/secure_random'

  def forgot_password
    
  end

  def create_reset_code
    @user = User.find_by_email(params[:email])

    if @user
      @user.create_reset_password_code

      flash[:notice] = "We're sending you an email with code to change your password."
      redirect_to '/'
    else
      flash[:error] = 'The email is not registered.'
      render :action => 'forgot_password'
    end
  end

  def change_password
    @user = User.find_by_reset_password_code(params[:reset_password_code])

    unless @user
      flash[:error] = 'The reset password code you entered is invalid'
      redirect_to '/'
    end
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      flash[:error] = "Failed to update your password"
      render :action => 'change_password'
    else
      if @user.update_attributes(params[:user])
        @user.update_attribute(:reset_password_code, nil)
        UserMailer.deliver_update_password_notification(@user)

        flash[:notice] = "Your password successfully updated."
        redirect_to login_url
      else
        flash[:error] = "Failed to update your password"
        render :action => 'change_password'
      end
    end
  end
end
