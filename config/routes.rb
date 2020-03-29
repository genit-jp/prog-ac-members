Rails.application.routes.draw do
  resources :profiles
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  root to: "profiles#index"
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
