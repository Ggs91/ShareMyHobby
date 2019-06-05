Rails.application.routes.draw do

  root 'event#index'
  devise_for :users
  resources :event
  resources :user

  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
	
end
