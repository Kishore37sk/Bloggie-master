# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: %i[show edit update]
  root  'topics#index'
  resources :tags
  resources :topics do
    resources :posts do
      resources :comments, only: %i[create destroy] do
        resources :user_comment_ratings, only: %i[create index]
      end
      resources :ratings, only: %i[create]
      member do
        post :post_read
      end
    end
  end

  get '/posts' => 'posts#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
