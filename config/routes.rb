GiveMeNotice::Application.routes.draw do
  resources :users
  match '/auth/twitter/callback', to: 'sessions#create', via: 'get'
end
