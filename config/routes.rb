# config/routes.rb
Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
      member do
      get :following, :followers
      end
    end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # -------------------------
  # TEMP ADMIN CREATION (PRODUCTION FREE TIER)
  # -------------------------
  if Rails.env.production?
    get '/create_admin', to: 'admin_setup#create_admin'
  end
  if Rails.env.development? || Rails.env.production?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
