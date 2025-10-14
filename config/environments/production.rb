require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ----------------------------
  # Code loading
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
  # config.assets.css_compressor = :sass

  # ----------------------------
  # Active Storage
  # ----------------------------
  # Nếu dùng S3, config ở storage.yml và uncomment dòng dưới
  config.active_storage.service = :local
  # config.active_storage.service = :amazon

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
  # Cache & Job
  # ----------------------------
  # config.cache_store = :mem_cache_store
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "hello_app_2_production"

  # ----------------------------
  # Mailer (SendGrid trên Render)
  # ----------------------------
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp

render_app_domain = ENV['RENDER_EXTERNAL_URL'] || 'toy-app-4-yajg.onrender.com'
config.action_mailer.default_url_options = { host: render_app_domain, protocol: 'https' }

config.action_mailer.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: render_app_domain,
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
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
  # Security (optional hosts)
  # ----------------------------
  config.hosts << render_app_domain
end
