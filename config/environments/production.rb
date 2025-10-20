# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ----------------------------
  # Code loading & caching
  # ----------------------------
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # ----------------------------
  # Static files & assets
  # ----------------------------
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.compile = false  # Precompile trước khi deploy
  config.assets.digest = true

  # ----------------------------
  # Active Storage (Cloudinary)
  # ----------------------------
  config.active_storage.service = :cloudinary

  # ----------------------------
  # Force SSL (HTTPS)
  # ----------------------------
  config.force_ssl = true

  # ----------------------------
  # Logging
  # ----------------------------
  config.log_level = :info
  config.log_tags  = [:request_id]

  logger = ActiveSupport::Logger.new($stdout)
  logger.formatter = ::Logger::Formatter.new
  config.logger = ActiveSupport::TaggedLogging.new(logger)
  config.log_to = %w[stdout]

  # ----------------------------
  # Mailer – Gửi Gmail thật
  # ----------------------------
  render_app_domain = ENV["RENDER_EXTERNAL_URL"] || "https://toy-app-4-yajg.onrender.com"

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = {
    host: render_app_domain,
    protocol: "https"
  }

  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV["GMAIL_USERNAME"],      # 👉 để trong Render environment
    password:             ENV["GMAIL_PASSWORD"],      # 👉 mật khẩu ứng dụng Gmail
    authentication:       "plain",
    enable_starttls_auto: true
  }

  # ----------------------------
  # I18n fallback
  # ----------------------------
  config.i18n.fallbacks = true

  # ----------------------------
  # Deprecations & Schema
  # ----------------------------
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  # ----------------------------
  # Security - Hosts
  # ----------------------------
  config.hosts.clear
  config.hosts << "toy-app-4-yajg.onrender.com"
  config.hosts << ".onrender.com" # Cho phép tất cả subdomain của Render
end
