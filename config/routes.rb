Rails.application.routes.draw do
  root to: 'wikis#index'

  resources :wikis do
    resources :pages, path: 'p'
  end
end
