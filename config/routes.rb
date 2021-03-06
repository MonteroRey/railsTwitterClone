Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get    "home",   to: "home#index"
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "logout", to: "sessions#destroy"
  get    "signup", to: "users#new"  #to routes into users/new.html.erb
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy]do
  member do
    get :following
    get :followers
  end
end
  resources :tweets, only: [:index, :create ,:destroy]


  resource  :relationship, only: [:create, :destroy]   #
  resolve("Relationship") { :relationship } #resolve polymorphic mappings from join table Relationship model to URL

  get "help",  to: "static_pages#help"   ###to render in the footer in the layout 
  get "about", to: "static_pages#about"  ###to render in the footer in the layout 
  # Defines the root path route ("/")
  # root "articles#index"

  resources :tweets do
    member do
      put 'like', to: 'tweets#like'    #put 'like', to: 'posts#upvote'
      put 'liked', to: 'tweets#liked'
    end
  end
  ######################## routes for comment ##############
  resources :comments, only: [:new, :create, :destroy]
  


end
