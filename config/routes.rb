Rails.application.routes.draw do

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :items do
      resources :reviews,only:[:show,:index,:destroy]
    end
    resources :users,only:[:edit,:update]
  end

  scope module: :public do
    root 'homes#top'

    get 'users/mypage' => 'public/users#show', as: 'mypage'
    get 'users/information/edit' => 'public/users#edit', as: 'edit_information'
    patch 'users/information' => 'public/users#update', as: 'update_information'
    get 'users/diagnosis' => "public/users#diagnosis", as: "diagnosis"
    get 'users/result' => "public/users#result", as: "result"
    patch 'users/save' => "public/users#save", as: "save"

    resources :users,only:[:show,:edit,:update]
    resources :items,only:[:index,:show] do
      resources :reviews,only:[:new,:create,:destroy]
      resource :favolites,only:[:create,:destroy]
    end
  end
  #devise_for :admins
  #devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

end
