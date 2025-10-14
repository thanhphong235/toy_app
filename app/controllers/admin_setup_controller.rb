# app/controllers/admin_setup_controller.rb
class AdminSetupController < ApplicationController
  def create_admin
    admin = User.find_or_initialize_by(email: "admin@example.com")
    admin.name = "Example Admin"
    admin.password = "newpassword"
    admin.password_confirmation = "newpassword"
    admin.admin = true
    admin.activated = true
    admin.activated_at = Time.zone.now
    if admin.save
      render plain: "Admin created: #{admin.email} / password: newpassword"
    else
      render plain: "Failed: #{admin.errors.full_messages.join(', ')}"
    end
  end
end
