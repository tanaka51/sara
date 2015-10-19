Rails.application.routes.draw do
  root to: 'top#index'

  resources :pages
  resources :wikis
end
