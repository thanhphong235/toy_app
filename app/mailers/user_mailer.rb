# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  # ----------------------------
  # Email gửi từ email thật, đã verify trên SendGrid
  # ----------------------------
  default from: 'noreply@toy-app-4-yajg.onrender.com' 
  # Thay bằng email domain thật của bạn đã verify trên SendGrid

  # ----------------------------
  # Account Activation Email
  # ----------------------------
  def account_activation(user)
    @user = user
    # Tạo link kích hoạt
    @activation_url = edit_account_activation_url(@user.activation_token, email: @user.email)

    mail(to: @user.email, subject: "Activate your account")
  rescue Net::OpenTimeout, Net::SMTPFatalError, Net::SMTPAuthenticationError => e
    # Log lỗi gửi email (timeout, auth fail, fatal)
    Rails.logger.error "[Email Error] Failed to send activation email to #{@user.email}: #{e.message}"
  end

  # ----------------------------
  # Password Reset Email
  # ----------------------------
  def password_reset(user)
    @user = user
    # Tạo link reset password
    @reset_url = edit_password_reset_url(@user.reset_token, email: @user.email)

    mail(to: @user.email, subject: "Reset your password")
  rescue Net::OpenTimeout, Net::SMTPFatalError, Net::SMTPAuthenticationError => e
    # Log lỗi gửi email
    Rails.logger.error "[Email Error] Failed to send password reset email to #{@user.email}: #{e.message}"
  end
end
