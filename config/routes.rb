Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"  
  resources :posts, only: [:index]
  get "up" => "rails/health#show", as: :rails_health_check
end
