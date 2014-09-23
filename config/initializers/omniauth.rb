Rails.application.config.middleware.use OmniAuth::Builder do
	google_options = {scope: 'http://gdata.youtube.com,userinfo.email,userinfo.profile,plus.me', access_type: 'online', approval_prompt: ''}
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], google_options
end