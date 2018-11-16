Rails.application.routes.draw do
  resources :tracks
  resources :bands, only: [:show] do
    resources :albums, only: [:new]
  end
  resources :users #, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :band
  resources :albums
end
