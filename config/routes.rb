Rails.application.routes.draw do
  root 'homes#top'
  get "home/about" => "homes#about", as: "about"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  # タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'posts', to: 'posts#search'
  end
end
