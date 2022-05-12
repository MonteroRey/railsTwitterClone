Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get    "home",   to: "home#index"
  get    "signup", to: "users#new"  #to routes into users/new.html.erb
  get    "login",  to: "sessions#new" 
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy]
  resources :tweets,       only: [:index, :create, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
