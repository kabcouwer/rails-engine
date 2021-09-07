# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#find'
      resources :merchants, only: %i[index show] do
        resources :items, module: 'merchants', only: [:index]
      end
      resources :items, only: %i[index show create update destroy] do
        resources :merchant, module: 'items', only: [:index]
      end
    end
  end
end
