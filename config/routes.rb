Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root  to: 'home#index'  #get '/', to: 'home#index' 
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index,:show, :new, :create]
  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show]
    end
  end
end
