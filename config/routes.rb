Rails.application.routes.draw do
  root 'events#index'
  resources :events, except: [:index] do
    resources :comments, only: [:create]
    resources :pictures, only: [:create]
  end

  devise_for :users do
    resources :profile_pictures, only: [:create]
  end

  resources :users, only: [:show]
  resources :participations, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :categories, only: [:show, :index] 
  resources :conversations do
    resources :messages
   
  end

  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
end
