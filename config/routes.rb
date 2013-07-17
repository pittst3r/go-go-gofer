Gofer::Application.routes.draw do

  root to: redirect('/dashboard')
  
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
