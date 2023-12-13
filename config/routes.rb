Rails.application.routes.draw do
  get 'orders/index'
  get 'user_pages/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
  resources 'books', only: [:index, :show]
  resources 'authors', only: [:index, :show]
  resources :users, only: [:show] do
    resources :orders, only: [:index]
  end
  resources 'orders', only: [:show, :create]
  resources 'user_pages', only: [:show]
  get 'books_by_genre/:genre_id', to: "home#index", as: :books_by_genre
  get 'home/index'
end
