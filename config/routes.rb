Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    get "my_posts", to: "posts#my_posts", as: :my_posts
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root "posts#index"
end
