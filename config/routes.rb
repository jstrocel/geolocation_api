Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #
  #
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :geolocations
    end
  end

  root 'api/v1/geolocations#index'
  # Defines the root path route ("/")
  # root "posts#index"
end
