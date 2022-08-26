Rails.application.routes.draw do
  devise_for :users
  root to: 'main#index'
  resources :discussions, only: %i[index show new create edit update destroy] do
    resources :posts, only: %i[create show edit update destroy], module: :discussions

    collection do
      get 'category/:id', to: 'categories/discussions#index', as: :category
    end

    resources :notifications, only: ['create'], module: :discussions
  end
  resources :categories

  resources :notifications, only: :index do
    collection do
      post '/mark_as_read', to: 'notifications#read_all', as: :read
    end
  end
end
