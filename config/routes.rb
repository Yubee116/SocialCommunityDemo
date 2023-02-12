Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :groups do
    collection do
      get :created_by_me
    end
  end

  resources :memberships
  devise_for :users

  # Defines the root path route ("/")
  root to: "groups#index"
end
