Rails.application.routes.draw do

  get 'comments/create'
  get 'profilpictures/create'
  root 'events#index'
  resources :events, except: [:index] do
    resources :comments, only: [:create]
  end

  devise_for :users do
    resources :profilpictures, only: [:create]
  end

  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'

end
