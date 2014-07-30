class HomeController < ApplicationController
  def index
  end

  def install_glass_service
    redirect_to "/auth/google_oauth2"
  end

  def install_done
    email = request.env["omniauth.auth"]["info"]["email"]
    return if user = User.find_by_email(email)

    user = User.new( :username => request.env["omniauth.auth"]["info"]["name"],
                     :email => request.env["omniauth.auth"]["info"]["email"] )


    puts request.env["omniauth.auth"]["credentials"]

    if user.save
      google_account = GoogleAccount.new()
      google_account.token = request.env["omniauth.auth"]["credentials"]["token"]
      google_account.refresh_token = request.env["omniauth.auth"]["credentials"]["refresh_token"]
      google_account.expires_at = request.env["omniauth.auth"]["credentials"]["expires_at"]
      google_account.email = request.env["omniauth.auth"]["info"]["email"]
      google_account.name = request.env["omniauth.auth"]["info"]["name"]
      google_account.id_token = request.env["omniauth.auth"]["extra"]["id_token"]
      google_account.user_id = user.id
      google_account.save
    end
  end
end