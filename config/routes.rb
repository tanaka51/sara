Rails.application.routes.draw do
  root to: 'wikis#index'

  resources :wikis do
    resources :pages, path: 'p', except: %i(index) do
      root to: 'wikis#show'
    end
  end
end
