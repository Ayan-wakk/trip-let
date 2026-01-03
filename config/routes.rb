Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "pages#home"
  resources :posts, only: %i[index new create show edit destroy update]
  get "up" => "rails/health#show", as: :rails_health_check

  get "/cleanup_once", to: "posts#cleanup"
end
