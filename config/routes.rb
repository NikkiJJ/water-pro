Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :bathing_sites do
    resources :reviews
    resources :favourites, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :favourites, only: [:destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
