Rails.application.routes.draw do
  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/destroy'
  end
  namespace :admin do
    get 'users/edit'
    get 'users/update'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'favolites/create'
    get 'favolites/destroy'
  end
  namespace :public do
    get 'reviews/new'
    get 'reviews/create'
    get 'reviews/destroy'
  end
  namespace :public do
    get 'homes/top'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/diagnosis'
    get 'users/result'
    get 'users/save'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  #devise_for :admins
  #devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

end
