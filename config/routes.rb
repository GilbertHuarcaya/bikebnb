Rails.application.routes.draw do
  devise_for :users
  root to: "bikes#index"

  resources :bikes do
    collection do
      get :top
      get :my_bikes
    end
    resources :rentals, only: [:create]
  end
  resources :rentals, only: [:destroy, :show, :update, :edit] do
    collection do
      get :my_rentals
      patch :complete
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
