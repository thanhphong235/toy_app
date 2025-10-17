source "https://rubygems.org"

ruby "3.2.2"

# ----------------------------
# Rails core
# ----------------------------
gem "rails", "~> 7.1.5", ">= 7.1.5.2"

# ----------------------------
# Front-end & Assets
# ----------------------------
gem "bootstrap-sass", "3.4.1"
gem "sassc", "~> 2.4"
gem "autoprefixer-rails"
gem "execjs"
gem "sprockets", "~> 4.2"
gem "sprockets-rails"
gem "active_storage_validations", "0.8.2"
gem "image_processing", "1.12"
gem "mini_magick", "4.9.5"
gem "cloudinary", "~> 2.4"
gem "activestorage-cloudinary-service"

# ----------------------------
# Email (cho phép dùng cả ở Render)
# ----------------------------
gem "letter_opener"
gem "letter_opener_web"
gem "sendgrid-ruby"

# ----------------------------
# JS runtime
# ----------------------------
gem "mini_racer", platforms: :ruby

# ----------------------------
# Authentication & Pagination
# ----------------------------
gem "bcrypt", "3.1.13"
gem "will_paginate", "~> 3.3.1"
gem "bootstrap-will_paginate", "1.0.0"

# ----------------------------
# Utilities
# ----------------------------
gem "faker", "~> 3.2"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# ----------------------------
# Database
# ----------------------------
group :development, :test do
  gem "sqlite3", ">= 1.7"
end

group :production do
  gem "pg", "~> 1.5", ">= 1.5.7"
  gem "aws-sdk-s3", require: false
end

# ----------------------------
# Server
# ----------------------------
gem "puma", ">= 5.0"

# ----------------------------
# JavaScript ecosystem
# ----------------------------
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# ----------------------------
# JSON builder
# ----------------------------
gem "jbuilder"

# ----------------------------
# Dev & Test
# ----------------------------
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
end
