Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "pages#top"
  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"
  get "/operator", to: "pages#operator"
  resources :posts, only: %i[index new create show edit destroy update]
  get "up" => "rails/health#show", as: :rails_health_check
end
