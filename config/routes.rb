Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  root 'posts#index'
  resources :posts, only: [:new, :create, :index, :show, :destroy]

end
