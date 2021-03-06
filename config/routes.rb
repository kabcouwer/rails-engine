# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#find'
      get 'items/find_all', to: 'items/search#find_all'

      resources :merchants, only: [:index, :show] do
        resources :items, module: 'merchants', only: [:index]
      end
      resources :items, except: [:new] do
        resources :merchant, module: 'items', only: [:index]
      end
      scope :revenue do
        get 'merchants', to: 'revenue#top_merchants'
        get 'merchants/:id', to: 'revenue#merchant'
        get 'items', to: 'revenue#top_items'
        get 'unshipped', to: 'revenue#unshipped'
      end
    end
  end
end
