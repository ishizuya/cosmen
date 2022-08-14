Rails.application.routes.draw do

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    resources :items
    resources :reviews,only:[:show,:destroy,:index]
    resources :users,only:[:edit,:update]
  end

  scope module: :public do
    root 'homes#top'

    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    get 'users/diagnosis' => "users#diagnosis", as: "diagnosis"
    get 'users/result' => "users#result", as: "result"
    patch 'users/save' => "users#save", as: "save"
    get 'user/favorites' => "users#favorites", as: "favorites"
    get 'items/ranking' => "items#ranking", as: "ranking"
    get 'items/whitening/ranking' => "items#whitening_ranking", as: "whitening_ranking"
    get 'items/wrinkle/ranking' => "items#wrinkle_ranking", as: "wrinkle_ranking"
    get 'items/moisturizing/ranking' => "items#moisturizing_ranking", as: "moisturizing_ranking"
    get 'items/acne_cure/ranking' => "items#acne_cure_ranking", as: "acne_cure_ranking"
    get 'items/irritation/ranking' => "items#irritation_ranking", as: "irritation_ranking"
    get 'search' => 'items#search'
    get 'reviews' => 'reviews#index', as: "reviews"

    resources :items,only:[:index,:show] do
      # collection do
      #   get 'top'
      # end
      resources :reviews,only:[:new,:create,:destroy]
      resource :favorites,only:[:create,:destroy]
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
