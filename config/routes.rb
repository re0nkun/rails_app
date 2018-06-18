Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:new, :create] do
    resource :relations, only: [:create, :destroy]
    get :following, on: :member
    get :followers, on: :member
    get :liked_post, on: :member
  end
  # resources :relations, only: [:create, :destroy]

  resources :posts, only: [:create, :destroy] do
    resource :likes, only: [:create, :destroy]
  end

  root :to => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
