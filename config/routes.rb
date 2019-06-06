Rails.application.routes.draw do

  get 'profilpictures/create'
  root 'event#index'
  devise_for :users do
    resources :profilpictures, only: [:create]
  end
  resources :event
  resources :user

  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'

end
