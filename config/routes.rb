Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :bathing_sites
  resources :bathing_sites do
    resources :reviews
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
