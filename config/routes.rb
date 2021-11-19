Rails.application.routes.draw do
  root to: 'rooms#index'

  resources :room_messages
  devise_for :users
  resources :rooms
end
