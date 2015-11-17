Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:create, :destroy, :edit, :show, :update] do
    resources :comments
  end
  root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
