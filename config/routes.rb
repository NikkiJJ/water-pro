Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :bathing_sites do
    resources :reviews, only: [ :new, :create]
    resources :favourites, only: [:create, :update]
    resources :reports, only: [:new, :create]
  end

  resources :reviews, except: [:new, :create] do
    resources :report_reviews, only: [ :new, :create ]
  end

  resources :report_reviews, only: [:create]

  resources :favourites, except: [:create, :update]

  get '/report_reviews/:id/confirmation', to: 'report_reviews#confirmation', as: :confirmed_review

  resources :pages

  resources :users do
    member do
      get 'admin_dashboard', to: 'users#admin_dashboard', as: :admin_dashboard
    end
  end

  resources :reports, only: [:show, :index, :update, :destroy ] do
    member do
      patch 'confirmation', to: 'reports#update_confirmation', as: :confirmation
    end
  end

  get '/report_confirmation_page/:id', to: 'reports#confirmation_page', as: :report_confirmation_page
end
