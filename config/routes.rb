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

  root "users#index"
  resources :posts
  resources :labels
  resources :letters
end
