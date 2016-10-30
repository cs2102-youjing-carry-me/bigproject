Rails.application.routes.draw do
  devise_for :users
  resources :bids do
  	member do
  		post :approve
  	end
  end
  resources :stuffs do
  	member do
  		post :bid, to: 'stuffs#bid_stuff'
  	end
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'stuffs#index'

  resources :reports, only: [] do
    collection do
      get 'popular_pickup'
      get 'popular_return'
    end
  end
end
