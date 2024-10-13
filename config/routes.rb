Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: :create do
        resources :frames,  param: :number, only: :update
      end
    end
  end
end
