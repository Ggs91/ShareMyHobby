Rails.application.routes.draw do

  resources :events, except: [:index] do
    resources :comments, only: [:create]
  end

  devise_for :users do
    resources :profile_pictures, only: [:create]
  end

  resources :participations, only: [:index, :create, :destroy]
  resources :users, only: [:show]
  
  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
end
