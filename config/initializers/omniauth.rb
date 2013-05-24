if Rails.env == 'e2e-test'
  OmniAuth.config.test_mode = true
  ENV['TWITTER_KEY'] = 'shiny'
  ENV['TWITTER_SECRET'] = 'shhhhh'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

