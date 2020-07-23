Rails.application.routes.draw do
  resources :code_reviews
  resources :answers
  resources :questions do
    collection do
      post 'api_post'
    end
  end
  resources :levels do
    collection do
      post 'check'
    end
  end
  get 'home/index'
  resources :members, only: [:index]
  resources :articles
  resources :bookings do
    collection do
      post 'slack'
    end
  end
  resources :attendances do
    collection do
      post 'slack'
    end
  end
  resources :daily_reports do
    collection do
      post 'slack'
    end
  end
  resources :profiles
  devise_for :admin_users, ActiveAdmin::Devise.config
  root to: "home#index"
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
