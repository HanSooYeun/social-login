OmniAuth.config.full_host = Rails.env.production? ? 'http://zoolu.co.kr' : 'http://localhost:3000'

Rails.application.middleware.use OmniAuth::Builder do
  provider( :twitter, Figaro.env.twitter_consumer_key, Figaro.env.twitter_consumer_secret )
  provider( :facebook, Figaro.env.facebook_app_id, Figaro.env.facebook_app_secret )
  provider( :google_oauth2, Figaro.env.google_client_id, Figaro.env.google_client_secret)
  # provider( :kakao, Figaro.env.kakao_client_id )
end