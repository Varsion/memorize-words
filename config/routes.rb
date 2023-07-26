Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :glossaries, only: [:index, :create, :update, :show] do
    member do
      put :add_vocabularies
    end

    resources :vocabularies, only: [:index, :show] do
      collection do
        get :sample
      end

      member do
        put :mark
      end
    end
  end
end
