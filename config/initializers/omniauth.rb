Rails.application.config.middleware.use OmniAuth::Builder do
  GOOGLE_CLIENT_ID = "371267539229-2gdhhadtd7es1l4uuq1nmh029oer5158.apps.googleusercontent.com"
  GOOGLE_CLIENT_SECRET = 'X2KrCpjKqOLx_OWNVig2C9Gv'
  provider :google_oauth2, GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, {
    :scope => "email, profile, https://www.googleapis.com/auth/glass.timeline"
  }
end