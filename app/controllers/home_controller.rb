class HomeController < ActionController::Base
  GOOGLE_CLIENT_ID = "371267539229-2gdhhadtd7es1l4uuq1nmh029oer5158.apps.googleusercontent.com"
  GOOGLE_CLIENT_SECRET = 'X2KrCpjKqOLx_OWNVig2C9Gv'
  def index
  end

  def install_glass_service
    redirect_to "/auth/google_auth2"
  end

  def install_done
    user = User.new( :username => request.env["omniauth.auth"]["info"]["name"],
                     :email => request.env["omniauth.auth"]["info"]["email"] )
    if user.save
      binding.pry
      google_account = GoogleAccount.new()
      google_account.token = request.env["omniauth.auth"]["credentials"]["token"]
      google_account.refresh_token = request.env["omniauth.auth"]["credentials"]["token"]
      google_account.expires_at = request.env["omniauth.auth"]["credentials"]["expires_at"]
      google_account.email = request.env["omniauth.auth"]["info"]["email"]
      google_account.name = request.env["omniauth.auth"]["info"]["name"]
      google_account.id_token = request.env["omniauth.auth"]["extra"]["id_token"]
      google_account.user_id = user.id
      google_account.save
    end
  end
end