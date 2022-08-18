Rails.application.routes.draw do
  devise_for :users
  root to: 'main#index'
  resources :discussions, only: %i[index show new create edit update destroy] do
    resources :posts, only: %i[create show edit update], module: :discussions
  end
end
