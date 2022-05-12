Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get    "home",   to: "home#index"
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  get    "signup", to: "users#new"  #to routes into users/new.html.erb
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
