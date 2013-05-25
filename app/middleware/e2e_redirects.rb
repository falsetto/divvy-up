# When running Angular e2e tests, the e2e runner proxies to the Rails
# app from (by default) http://localhost:8080. This middleware ensures
# that redirects coming back from the Rails app use
# 'http://localhost:8080' as the protocol, host, and port.
#
# You should direct Rails to use this middleware in your custom
# config/environments/e2e_test.rb file:
#
#   config.middleware.use 'E2eRedirects'
#   
require 'uri'
class E2eRedirects
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    if headers['Location']
      uri = URI(headers['Location'])
      headers['Location'] = "http://localhost:8080#{uri.path}#{uri.query}#{uri.fragment}"
    end

    [status, headers, response]
  end
end
