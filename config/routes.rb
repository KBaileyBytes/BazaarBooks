Rails.application.routes.draw do
  get 'shopping_cart/index'
  get 'shopping_cart/create'
  get 'shopping_cart/destroy'
  get 'orders/index'
  get 'user_pages/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
  resources 'books', only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  resources 'authors', only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show] do
    resources :orders, only: [:index, :show]
  end
  resources 'orders', only: [:show, :create]
  resources 'user_pages', only: [:show]
  get 'books_by_genre/:genre_id', to: "home#index", as: :books_by_genre
  get '/search', to: 'application#search', as: 'search'
  get 'home/index'
  resources :shopping_cart, only: [:index, :create, :destroy] do
    post 'add/:product_id', action: :add, on: :collection, as: :add_to_cart
    delete 'remove/:product_id', action: :remove, on: :collection, as: :remove_from_cart
    delete 'clear', action: :clear, on: :collection, as: :clear_cart
  end
end
