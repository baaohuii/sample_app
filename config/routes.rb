Rails.application.routes.draw do
  root "static_page#home"
  get "users/show"
  get "static_pages/home"
  get "static_page/help"

  get "/signup", to: "users#new"
  post "/signup", to:"users#create"
  resources :users
end
