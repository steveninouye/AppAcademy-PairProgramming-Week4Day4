Rails.application.routes.draw do
  resources :bands, only: [:show] do
    resources :albums, only: [:new]
  end
  resources :albums, only: [:show] do
    resources :tracks, only: [:new]
  end
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
  resources :albums, only: [:create, :edit, :show, :update, :destroy]
  resources :bands
  resources :users #, only: [:create, :new, :show]
end
