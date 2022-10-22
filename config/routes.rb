Rails.application.routes.draw do
  namespace :public do
    get 'searches/search'
  end
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root "homes#top"
    get 'about' => "homes#about"
    resources :items, only: [:index, :show]
    get 'customers/my_page' => "customers#show"
    get 'customers/information/edit' => "customers#edit"
    patch 'customers/information' => "customers#update"
    get 'customers/confirm'
    patch 'customers/withdraw'
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    get 'orders/finish'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm'
    resources :shipping_addresses, only: [:create, :index, :edit, :update, :destroy]
    get "searches" => "searches#search"
  end

  namespace :admin do
    root "homes#top"
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
