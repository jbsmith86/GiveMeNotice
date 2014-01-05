GiveMeNotice::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :alerts
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  root "users#index"
end
