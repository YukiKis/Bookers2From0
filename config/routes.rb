Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#home"
  get "/about", to: "homes#about"
end
