Rails.application.routes.draw do
  get 'home/index'
  resources :articles
  resources :bookings
  resources :attendances do
    collection do
      post 'slack'
    end
  end
  resources :profiles
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  root to: "home#index"
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
