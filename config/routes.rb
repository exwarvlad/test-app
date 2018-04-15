Rails.application.routes.draw do
  resources :posts, only: :create do
    resources :rates, only: :create
  end
end
