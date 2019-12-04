Rails.application.routes.draw do

  get 'static_pages/home'

  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/about'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'sessions/new'

  get 'users/new'


  resources :users
end