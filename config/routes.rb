Rails.application.routes.draw do
  root to: 'static_pages#home'
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users
  resources :posts, only: [:create, :destroy, :edit, :show, :update] do
    resources :comments, only: [:create, :destroy]
  end

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  # match '/signup',  to: 'users#new',            via: 'get'

  # match '/signin',  to: 'sessions#new',         via: 'get'
  # match '/signout', to: 'sessions#destroy',     via: 'delete'
end
