Rails.application.routes.draw do
  devise_for :users
  root to: "bikes#index"

  resources :bikes do
    collection do
      get :top
      get :my_bikes
    end
    resources :rentals
  end
  resources :rental, only: [:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
