GiveMeNotice::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  get '/auth/twitter/callback', to: 'sessions#create'
  root "user#index"
end
