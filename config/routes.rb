Rails.application.routes.draw do

  get 'profilpictures/create'
  root 'events#index'
  resources :events, except: [:index]

  devise_for :users do
    resources :profilpictures, only: [:create]
  end

  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'

end
