Rails.application.routes.draw do
  namespace :api do
    namespace :v1, default: {format: 'json'} do
      resources :plants, only: [:index]
      mount_devise_token_auth_for 'User',
                                  at: 'auth', skip: [:omniauth_callbacks],
                                  controllers: {
                                      sessions: 'api/v1/sessions'
                                  }
      resources :users, only: [:show] do
        resources :user_plants, only: [:create]
      end
    end
  end
end
