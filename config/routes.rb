Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  root "users#index"
  resources :posts
  resources :labels
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :letters
  end
end
