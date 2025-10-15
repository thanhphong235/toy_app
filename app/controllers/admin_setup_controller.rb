# app/controllers/admin_setup_controller.rb
class AdminSetupController < ApplicationController
  def create_admin
  admin = User.find_or_initialize_by(email: "admin@example.com")
  admin.name = "Example Admin"
  admin.password = "phong123"
  admin.password_confirmation = "phong123"
  admin.admin = true
  admin.activated = true
  admin.activated_at = Time.zone.now
  if admin.save!
    render plain: "Admin created: #{admin.email} / password: phong123"
  else
    render plain: "This line will never show because save! raises exception on failure"
  end
end

end
