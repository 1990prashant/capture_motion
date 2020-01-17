Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/signup', to: 'users#create', as: :signup
      post '/login', to: 'sessions#create', as: :login
      resources :products
      resources :categories do
        resources :products, only: :index
      end

      resources :carts, only: [:index, :create]
    end
  end
end
