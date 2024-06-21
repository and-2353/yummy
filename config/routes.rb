Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  
  resources :tweets, only: %i(new create) do
    collection do
      post :sentiment
    end
  end
end