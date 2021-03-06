Rails.application.routes.draw do
  root "static_page#home"
  get "static_page/home"
  get "/help", to: "static_page#help"
  get "/signup", to: "users#new"
  get "sessions/new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "users/show"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: :edit
  resources :password_resets
  resources :microposts, only: %i(:create, :destroy)
  resources :relationships, only: %i(:create, :destroy)
end
