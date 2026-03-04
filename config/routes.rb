Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "pages#top"
  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"
  get "/operator", to: "pages#operator"

  resources :posts, only: %i[index new create show edit destroy update] do
    resource :like, only: %i[create destroy]
  end

  resources :users, only: [:show] do
    member do
      get :likes
    end
  end

  namespace :users do
    resource :profile, only: [:edit, :update]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
