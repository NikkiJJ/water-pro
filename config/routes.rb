Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :bathing_sites do
    resources :reviews
    resources :favourites, only: [:create]
    get '/reports/new', to: 'reports#new', as: 'new_report'
    post '/reports', to: 'reports#create', as: 'reports'
    get '/report_confirmation_page', to: 'reports#confirmation_page'
  end

  resources :favourites, only: [:destroy]

  resources :pages

  resources :users

  resources :reports, only: [:show]

end
