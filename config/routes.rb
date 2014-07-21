GoogleGlassPp77::Application.routes.draw do

  post 'glass/notifications', to: 'glass/notifications#callback', as: 'glass_notifications_callback'
  root 'home#index'

  get '/install' => 'home#install_glass_service'
  match "/auth/google_oauth2/callback" => "home#install_done", via: :get
  match "/send_notification" => "messages#send_message", via: :get
end
