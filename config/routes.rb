Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:create, :show] do
        resources :frames, param: :number, only: [:update, :create]
      end
    end
  end
end
