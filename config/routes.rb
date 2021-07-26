Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  get "home/about" => "homes#about" , as: "about"
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]

  #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'posts', to: 'posts#search'
  end

end
