Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

    get "admin/users/index"=>"admin/users#index"
    patch "freeze/:id"=>"admin/users#freeze", as: 'user_freeze'
    patch "unfrieze/:id"=>"admin/users#unfrieze", as: 'user_unfreeze'
    get "favorite_index"=>"projects#favorite_index"
    
  root :to =>"homes#top"
  get "about"=>"homes#about"
  get 'search' => 'searches#search'
  get 'project_comments/index' => 'project_comments#index'
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create]
  resources :contacts, only: [:new, :create]
  resources :projects do
    resources :project_comments, only: [:create, :destroy]
    resources :join_projects, only: [:create, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
    get "joined_user_index"=>"projects#joined_user_index"
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    get "search_users_project" => "searches#search_users_project"
    get "joined_project_index"=>"projects#joined_project_index"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end