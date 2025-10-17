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
  # Render yêu cầu biến môi trường RAILS_SERVE_STATIC_FILES=true để phục vụ assets
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile  = false  # assets đã precompile trước khi deploy
  config.assets.digest   = true

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

  logger           = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = ::Logger::Formatter.new
  config.logger    = ActiveSupport::TaggedLogging.new(logger)

  # ----------------------------
  # Mailer (SendGrid)
  # ----------------------------
  render_app_domain = ENV['RENDER_EXTERNAL_URL'] || 'toy-app-4-yajg.onrender.com'
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: render_app_domain, protocol: 'https' }

  config.action_mailer.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 587,
    domain:               render_app_domain,
    user_name:            'apikey',                 # luôn là 'apikey' khi dùng SendGrid API key
    password:             ENV['SENDGRID_API_KEY'],  # set biến môi trường SENDGRID_API_KEY trên Render
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
  # Deprecations & Schema
  # ----------------------------
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  # ----------------------------
  # Security - Hosts
  # ----------------------------
  # Chỉ cho phép domain app trên Render để tránh lỗi Blocked hosts
  config.hosts.clear
  config.hosts << render_app_domain
  config.hosts << "www.#{render_app_domain}" # nếu cần

  # ----------------------------
  # Additional optional settings
  # ----------------------------
  # Nếu gặp loop redirect SSL khi dùng proxy, có thể thêm:
  # config.ssl_options = { redirect: { exclude: -> request { request.path =~ /healthcheck/ } } }
end
