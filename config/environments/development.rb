require "active_support/core_ext/integer/time"

Rails.application.configure do
  # -----------------------------
  # Code Reloading
  # -----------------------------
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  # -----------------------------
  # Assets
  # -----------------------------
  config.public_file_server.enabled = true
  config.assets.compile = true
  config.assets.digest = false
  config.assets.quiet = true

  # -----------------------------
  # Caching
  # -----------------------------
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # -----------------------------
  # Active Storage
  # -----------------------------
  config.active_storage.service = :local

  # -----------------------------
  # Action Mailer – Gửi Gmail thật
  # -----------------------------
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            "tu1den19@gmail.com",      # 👉 Gmail thật của bạn
    password:             "emppwrkouvidszcy",        # 👉 mật khẩu ứng dụng (16 ký tự, không có khoảng trắng)
    authentication:       "plain",
    enable_starttls_auto: true
  }

  # -----------------------------
  # Deprecation & Migration
  # -----------------------------
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_job.verbose_enqueue_logs = true

  # -----------------------------
  # Other
  # -----------------------------
  config.action_controller.raise_on_missing_callback_actions = true
end
