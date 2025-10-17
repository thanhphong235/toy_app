# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ----------------------------
  # Code loading & caching
  # ----------------------------
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # ----------------------------
  # Static files & assets
  # ----------------------------
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.assets.digest  = true

  # ----------------------------
  # Active Storage (Cloudinary)
  # ----------------------------
  config.active_storage.service = :cloudinary

  # ----------------------------
  # Force SSL
  # ----------------------------
  config.force_ssl = true

  # ----------------------------
  # Logging
  # ----------------------------
  config.log_level = :info
  config.log_tags  = [:request_id]

  logger = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = ::Logger::Formatter.new
  config.logger = ActiveSupport::TaggedLogging.new(logger)

  # ----------------------------
  # Mailer (SendGrid)
  # ----------------------------
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp

  # Host domain (Render)
  render_app_domain = ENV['RENDER_EXTERNAL_URL'] || 'toy-app-4-yajg.onrender.com'
  config.action_mailer.default_url_options = { host: render_app_domain, protocol: 'https' }

  # SendGrid SMTP settings
  config.action_mailer.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 587,
    domain:               render_app_domain,
    user_name:            'apikey',                 # luôn là 'apikey' khi dùng SendGrid API key
    password:             ENV['SENDGRID_API_KEY'],  # đặt biến môi trường SENDGRID_API_KEY
    authentication:       :plain,
    enable_starttls_auto: true,
    open_timeout:         15,
    read_timeout:         15
  }

  # ----------------------------
  # I18n fallback
  # ----------------------------
  config.i18n.fallbacks = true

  # ----------------------------
  # Deprecation & Schema
  # ----------------------------
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  # ----------------------------
  # Security - Hosts
  # ----------------------------
  config.hosts.clear
  config.hosts << render_app_domain
end
