Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  root "users#index"

  resources :labels

  resources :letters do
    collection do
      get :starred
      get :sendmail
      get :trash
    end
  end

  namespace :api do
    resources :letters, only: [] do
      member do
        post :star
      end
    end
  end

  resources :orders, only: [] do
    collection do
      get :payment
      post :payment_response
    end
  end
end
