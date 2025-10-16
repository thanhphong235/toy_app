require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ----------------------------
  # Code loading
  # ----------------------------
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # ----------------------------
  # Static files & assets
  # ----------------------------
  config.public_file_server.enabled = true
  config.assets.compile = false

  # ----------------------------
  # Active Storage
  # ----------------------------
  config.active_storage.service = :cloudinary

  # ----------------------------
  # SSL
  # ----------------------------
  config.force_ssl = true

  # ----------------------------
  # Logging
  # ----------------------------
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [:request_id]

  logger = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = ::Logger::Formatter.new
  config.logger = ActiveSupport::TaggedLogging.new(logger)

  # ----------------------------
  # Mailer (SendGrid)
  # ----------------------------
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  render_app_domain = ENV['RENDER_EXTERNAL_URL'] || 'toy-app-4-yajg.onrender.com'
  config.action_mailer.default_url_options = { host: render_app_domain, protocol: 'https' }

  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    domain: 'render.com',
    user_name: 'apikey',
    password: ENV['SENDGRID_API_KEY'],
    authentication: :plain,
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }

  # ----------------------------
  # Internationalization
  # ----------------------------
  config.i18n.fallbacks = true

  # ----------------------------
  # Deprecations & Schema
  # ----------------------------
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  # ----------------------------
  # Security (hosts)
  # ----------------------------
  config.hosts.clear
end
