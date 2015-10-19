Rails.application.routes.draw do
  root to: 'wikis#index'

  resources :pages
  resources :wikis
end
