Rails.application.routes.draw do
  get "books/search", to: "books#search"
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "homes#home"
  get "/about", to: "homes#about"
end
