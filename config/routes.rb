Rails.application.routes.draw do
  root 'links#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'

  resources :links, only: [:edit, :update]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:index, :create, :update]
    end
  end
end
