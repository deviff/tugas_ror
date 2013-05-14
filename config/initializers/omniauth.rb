Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, [153139011502431], ['1bcd908a747e78ae59098e01a7c3dd66'], {:scope => 'email'}
 
  # If you want to also configure for additional login services, they would be configured here.
end