Rails.application.routes.draw do
  root 'lists#index'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :lists, only: [:index, :new, :create, :show, :destroy] do
    resources :bookmarks, only: [:new, :create, :destroy]
  end

  resources :bookmarks, only: [:destroy]
end
