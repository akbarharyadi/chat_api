# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins do |origin, _env|
      allowed = ENV.fetch("CORS_ORIGINS", "http://localhost:5173 http://localhost:3000")
      allowed.split.any? { |allowed_origin| allowed_origin.strip.casecmp?(origin) }
    end

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      credentials: false
  end
end
