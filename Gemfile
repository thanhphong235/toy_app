source "https://rubygems.org"

ruby "3.2.2"

# Rails core
gem "rails", "~> 7.1.5", ">= 7.1.5.2"

# Front-end & Assets
gem 'bcrypt', "3.1.13"
gem "bootstrap-sass", "3.4.1"
gem "sassc", "~> 2.4"
gem "autoprefixer-rails"
gem "execjs"
gem "sprockets-rails"
gem "sprockets", "~> 4.2"

# Database
group :development, :test do
  gem "sqlite3", ">= 1.4"
end

group :production do
  gem "pg", "~> 1.5", ">= 1.5.7"
end

# Server
gem "puma", ">= 5.0"

# JavaScript ecosystem
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# JSON builder
gem "jbuilder"

# Misc
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

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
