class UserMailer < ApplicationMailer
  default from: 'noreply@yourdomain.com' # đổi sang email domain thật

  # ----------------------------
  # Account Activation Email
  # ----------------------------
  def account_activation(user)
    @user = user
    @activation_url = edit_account_activation_url(@user.activation_token, email: @user.email)

    mail to: @user.email, subject: "Activate your account"
  rescue Net::OpenTimeout, Net::SMTPFatalError, Net::SMTPAuthenticationError => e
    Rails.logger.error "[Email Error] Failed to send activation email to #{@user.email}: #{e.message}"
  end

  # ----------------------------
  # Password Reset Email
  # ----------------------------
  def password_reset(user)
    @user = user
    @reset_url = edit_password_reset_url(@user.reset_token, email: @user.email)

    mail to: @user.email, subject: "Reset your password"
  rescue Net::OpenTimeout, Net::SMTPFatalError, Net::SMTPAuthenticationError => e
    Rails.logger.error "[Email Error] Failed to send password reset email to #{@user.email}: #{e.message}"
  end
end
