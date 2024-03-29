Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "reviews#index"

  get 'info', to: 'static_pages#info', as: :info
  get 'terms', to: 'static_pages#terms', as: :terms
  get 'privacy', to: 'static_pages#privacy', as: :privacy

  # get 'login', to: 'user_sessions#new', as: :login
  # post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  post "/oauth/:provider/callback" => "oauths#callback"
  get "/oauth/:provider/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#oauth", :as => :auth_at_provider

  delete 'delete', to: 'users#destroy', as: :user_delete
  resources :users, only: %i[edit update]

  resources :reviews do
    get 'favorites', on: :collection
  end
  get 'own/:user_id', to: 'reviews#own_reviews', as: :own

  resources :favorites, only: %i[create destroy]

  get 'tags/search', to: 'tags#search'
  get 'tags/all_search', to: 'tags#all_search'
  get 'organizers/search', to: 'organizers#search'
end
