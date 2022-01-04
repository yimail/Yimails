Rails.application.routes.draw do
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
end