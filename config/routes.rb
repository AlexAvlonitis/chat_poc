Rails.application.routes.draw do
  root to: 'rooms#index'

  resources :rooms, only: :index
  resources :messages, only: :create
  devise_for :users
end
