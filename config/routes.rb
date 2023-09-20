Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :bathing_sites do
    resources :reviews
    resources :favourites, only: [:create]
    resources :reports, only: [:new, :create]
  end

  resources :favourites, only: [:destroy]

  resources :pages

  resources :users

  resources :reports, only: [:show]
  get '/report_confirmation_page/:id', to: 'reports#confirmation_page', as: :report_confirmation_page
end
