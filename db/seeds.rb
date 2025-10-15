# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Xoá user cũ (chỉ dev/test)
User.delete_all if Rails.env.development? || Rails.env.test?
Faker::UniqueGenerator.clear

# Tạo admin luôn với password cố định
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.name = "Example Admin"
admin.password = "newpassword"            # mật khẩu bạn muốn dùng để login
admin.password_confirmation = "newpassword"
admin.admin = true
admin.activated = true
admin.activated_at = Time.zone.now
admin.save!

# Tạo 99 user ngẫu nhiên
99.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email

  User.create!(
    name: name,
    email: email,
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now
  )
end

puts "Seed finished: 1 admin + 99 users created."

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.microposts.create!(content: content) }
end
