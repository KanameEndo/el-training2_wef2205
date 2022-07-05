Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :labels
  resources :users
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
