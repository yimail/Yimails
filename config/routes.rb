Rails.application.routes.draw do
  namespace :api do
    resources :letters, only: [] do
      member do
        # /api/letters/3/star
        post :star
      end
    end
  end

  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  get "/starred", to: "letters#starred"
  get "/sendmail", to: "letters#sendmail"
  get "/trash", to: "letters#trash"

  root "users#index"
  resources :posts
  resources :labels
  resources :letters
  get "/payment", to: "orders#payment" 
  post "/payment_response", to: "orders#payment_response"
end
