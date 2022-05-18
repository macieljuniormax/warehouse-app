Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root  to: 'home#index'  #get '/', to: 'home#index' 
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  get '/suppliers', to: 'suppliers#index'
  resources :suppliers, only: [:show, :new, :create, :edit, :update]

  # CRUD
  # Create  Criar
  # Read    Ler
  # Update  Atualizar
  # Destroy Apagar

end
