Rails.application.routes.draw do
  root 'staic_pages#home'
  get 'staic_pages/home', to: "staic_pages#home"

  get 'users/new'
  
  get    '/login',   to: 'staic_pages#home'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # post 'auth/login', to: 'authentication#authenticate'

  resources :users do
    resources :articles
  end

  resources :articles do
    resources :comments
  end


  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
