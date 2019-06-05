Rails.application.routes.draw do

  root 'event#index'
  devise_for :users
  resources :event
  resources :user

  get 'contact', to: 'welcome#contact'
  get 'about', to: 'welcome#about'
	
end
