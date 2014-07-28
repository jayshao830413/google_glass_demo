class User < ActiveRecord::Base

  has_one :google_account

  def refresh_token_if_expired
  	GOOGLE_APP_KEY = "371267539229-2gdhhadtd7es1l4uuq1nmh029oer5158.apps.googleusercontent.com"
  	GOOGLE_APP_SECRET = "X2KrCpjKqOLx_OWNVig2C9Gv"
	  if token_expired?
	  	data = {
			  :client_id => GOOGLE_APP_KEY,
			  :client_secret => GOOGLE_APP_SECRET,
			  :refresh_token => self.google_account.refresh_token,
			  :grant_type => "refresh_token"
			}

			response = RestClient.post "https://accounts.google.com/o/oauth2/token", data
	    refreshhash = JSON.parse(response.body)
	    binding.pry
	    self.google_account.token     = refreshhash['access_token']
	    self.google_account.expires_at = DateTime.now + refreshhash["expires_in"].to_i.seconds

	    self.save
	    puts 'Saved'
	  end
	end

	def token_expired?
	  expiry = Time.at(self.google_account.expires_at) 
	  return true if expiry < Time.now # expired token, so we should quickly return
	  token_expires_at = expiry
	  save if changed?
	  false # token not expired. :D
	end

end
