Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  root 'posts#index'
  get 'posts/followings'
  resources :posts, only: [:create]
  resources :users, only: [:show]
  resources :user_relations, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
