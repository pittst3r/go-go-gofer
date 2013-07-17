Gofer::Application.routes.draw do
  
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"

  root to: redirect('/dashboard')
  
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
  resources :gofer_runs, only: [] do
    member do
      put :clear
      put :close
    end
  end
  
  match '/dashboard' => 'dashboard#show', as: 'dashboard'

end
