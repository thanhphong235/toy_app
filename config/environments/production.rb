require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ----------------------------
  # Code loading
  # ----------------------------
  # Cache classes and eager load code for better performance
  config.cache_classes = true
  config.eager_load = true

  # Full error reports are disabled and caching is enabled
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # ----------------------------
  # Static files & assets
  # ----------------------------
  # Enable Rails to serve static files if environment variable is set (needed if no NGINX/Apache)
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Do not compile assets on the fly in production
  config.assets.compile = false
  # config.assets.css_compressor = :sass  # uncomment if you want CSS compression

  # ----------------------------
  # Active Storage
  # ----------------------------
  # Store uploaded files (local for testing, S3 recommended in real production)
  config.active_storage.service = :local
  # For S3, uncomment below and configure config/storage.yml
  # config.active_storage.service = :amazon

  # ----------------------------
  # SSL
  # ----------------------------
  # Force all access over SSL and use secure cookies
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
  # Use different cache store if needed
  # config.cache_store = :mem_cache_store

  # Active Job queue adapter
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "hello_app_2_production"

  # ----------------------------
  # Mailer
  # ----------------------------
  config.action_mailer.perform_caching = false
  # config.action_mailer.default_url_options = { host: 'yourdomain.com', protocol: 'https' }
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.example.com',
  #   port: 587,
  #   user_name: ENV['SMTP_USERNAME'],
  #   password: ENV['SMTP_PASSWORD'],
  #   authentication: 'plain',
  #   enable_starttls_auto: true
  # }

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
  # config.hosts << "yourdomain.com"
end
