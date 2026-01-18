require "active_support/core_ext/integer/time"

Rails.application.configure do
  # --- 基本設定 ---
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  config.active_storage.service = :b2
  config.force_ssl = true
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false
  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # --- メール送信設定 ---
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  # --- メールのリンク先URLと画像のホスト設定 ---
  config.action_mailer.default_url_options = { host: 'trip-let.onrender.com', protocol: 'https' }
  config.action_mailer.asset_host = 'https://trip-let.onrender.com'
 
  config.action_mailer.smtp_settings = {
    address:              'smtp-relay.brevo.com',
    port:                 465,
    domain:               'trip-let.onrender.com',
    user_name:            ENV['BREVO_USER'],     # Renderで設定したメールアドレス
    password:             ENV['BREVO_PASSWORD'], # コピーした64文字の長いキー
    authentication:       'plain',
    enable_starttls_auto: false,  # ← falseに変更
    ssl:                  true,    # ← 追加
    open_timeout:         30,      # ← タイムアウト設定を追加
    read_timeout:         30       # ← タイムアウト設定を追加
  }

  # --- その他 ---
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # DNS保護設定（必要に応じてコメントアウトを外す）
  # config.hosts = [ "trip-let.onrender.com" ]
end