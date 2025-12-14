Rails.application.routes.draw do
  root "pages#home"  
  resources :posts, only: [:index]
  get "up" => "rails/health#show", as: :rails_health_check
end
