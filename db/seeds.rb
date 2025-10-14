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

# Tạo admin
User.create!(
  name: "Example Admin",
  email: "admin@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

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
