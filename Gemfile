source "https://rubygems.org"

ruby "3.0.2"

# Rails core
gem "rails", "~> 7.1.5", ">= 7.1.5.2"

# Front-end & Assets
gem "bootstrap-sass", "3.4.1"
gem "sassc", "~> 2.4"               # cần cho bootstrap-sass
gem "autoprefixer-rails"            # cần để compile CSS mượt hơn
gem "execjs"                        # cho JS runtime khi compile assets
gem "sprockets-rails"               # asset pipeline
gem "sprockets", "~> 4.2"           # đảm bảo tương thích Rails 7

# Database
gem "sqlite3", ">= 1.4"

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
end
