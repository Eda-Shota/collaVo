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
  
  root :to =>"homes#top"
  get "about"=>"homes#about"
  get 'search' => 'searches#search'
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create]  
  resources :projects do
    resources :project_comments, only: [:create, :destroy]
    resource :join_projects, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get "projects/joined_index"=>"projects#joined_index"

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    get "search_users_project" => "searches#search_users_project"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
