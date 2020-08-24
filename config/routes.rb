Rails.application.routes.draw do
  root "static_page#home"
  get "static_pages/home"
  get "static_page/help"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
