Rails.application.routes.draw do
  namespace :api do
    namespace :v1, default: { format: 'json' } do
      resources :plants, only: [:index]
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :users, only: [:show] do
        resources :user_plants, only: [:create, :index]
      end
    end
  end
end
