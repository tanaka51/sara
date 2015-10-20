Rails.application.routes.draw do
  root to: 'wikis#index'

  resources :wikis do
    resources :pages, path: 'p'
    resource :sidebar, except: %i(show new create destroy)
  end
end
