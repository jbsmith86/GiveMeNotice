GiveMeNotice::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :alerts
  get '/auth/twitter/callback', to: 'sessions#create'
  root "users#index"
end
