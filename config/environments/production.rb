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
  # Cho phép Render serve static files
  config.public_file_server.enabled = true
  config.assets.compile = false
  # config.assets.css_compressor = :sass
  # config.assets.js_compressor = :uglifier

  # ----------------------------
  # Active Storage
  # ----------------------------
  config.active_storage.service = :cloudinary
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
  # config.active_job.queue_adapter = :async
  # config.active_job.queue_name_prefix = "toy_app_production"

  # ----------------------------
  # Mailer (SendGrid)
  # ----------------------------
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  # Dùng domain Render thật (ví dụ: https://toy-app-4-yajg.onrender.com)
  render_app_domain = ENV['RENDER_EXTERNAL_URL'] || 'toy-app-4-yajg.onrender.com'
  config.action_mailer.default_url_options = { host: render_app_domain, protocol: 'https' }

  # Cấu hình SMTP SendGrid
  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    domain: 'render.com', # domain của nhà cung cấp, không phải app domain
    user_name: 'apikey', # LUÔN là chữ 'apikey' literal
    password: ENV['SENDGRID_API_KEY'], # đổi sang biến SENDGRID_API_KEY để dễ hiểu
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
  # Security (hosts)
  # ----------------------------
  # Cho phép tất cả host (Render tự cấp domain)
  config.hosts.clear
end
