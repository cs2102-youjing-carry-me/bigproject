Rails.application.routes.draw do
  devise_for :users
  resources :bids
  resources :stuffs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'bids#index'
end
