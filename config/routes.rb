Rails.application.routes.draw do
  root 'home#index'
  get 'users/new'
  get 'home/index'
  get    '/login',   to: 'home#index'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
