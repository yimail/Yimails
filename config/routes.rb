Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  root "users#index"
  resources :posts
  resources :labels
  resources :letters
  get "/payment", to: "orders#payment" 
  post "/payment_response", to: "orders#payment_response"
end
