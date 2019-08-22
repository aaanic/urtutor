Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :tutorials
  resources :lessons, only: [:new, :create]
  get '/dashboard', to: 'pages#user_dashboard'
end
