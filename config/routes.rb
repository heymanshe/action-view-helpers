Rails.application.routes.draw do
  get "users/index"
  get "users/show"
  get "articles/index"
  get "sessions/new"
  get "sessions/create"
  get "profiles/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  resources :profiles, only: [ :show ]
  resources :sessions, only: [ :new, :create ]

  resources :articles, only: [ :index, :show ]
  root "articles#index"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # root "profiles#show" # Set a default page to test
  resources :users, only: [ :index, :show ]

  # root "users#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
