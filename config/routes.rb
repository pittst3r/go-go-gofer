Gofer::Application.routes.draw do
  
  resources :preferences


  root to: redirect('/dashboard')
  
  get 'pages/styles' => 'pages#styles_demo'
  
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  
  resources :password_resets
  resources :user_sessions
  match '/log-in' => 'user_sessions#new', as: 'log_in'
  match '/log-out' => 'user_sessions#destroy', as: 'log_out'
  
  resources :organizations
  resources :orders do
    member do
      put :accept
    end
  end
  resources :gofer_runs do
    member do
      put :clear
      put :close
    end
  end
  
  get '/dashboard' => 'dashboard#show', as: 'dashboard'
  
  get '/settings' => 'settings#edit', as: 'settings'
  put '/settings' => 'settings#update'

end
