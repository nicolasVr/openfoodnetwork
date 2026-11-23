# frozen_string_literal: true

# Absolute URLs generated in development default to localhost:3000
# (config/environments/development.rb). When the app runs behind a TLS proxy,
# those URLs (mailers, attachments, DFC @id) must point at the public origin
# instead. Opt in with e.g. DEV_URL_OPTIONS="https://10.195.51.150:8445".
if Rails.env.development? && ENV.fetch("DEV_URL_OPTIONS", nil).present?
  uri = URI.parse(ENV.fetch("DEV_URL_OPTIONS"))
  url_options = { host: uri.host, port: uri.port, protocol: uri.scheme }

  ActionController::Base.default_url_options = url_options
  ActionMailer::Base.default_url_options = url_options
  Rails.application.routes.default_url_options.merge!(url_options)
  DfcProvider::Engine.routes.default_url_options.merge!(url_options)
end
