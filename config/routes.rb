Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get 'search' => 'searches#search'
  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]  


  resources :projects do
    resources :project_comments, only: [:create, :destroy]
    resource :join_projects, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
