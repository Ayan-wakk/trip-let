OmniAuth.config.full_host = if Rails.env.production?
  "https://trip-let.jp"
else
  "http://localhost:3000"
end
