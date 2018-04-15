Rails.application.routes.draw do
  resources :posts, only: %i[create index] do
    resources :rates, only: :create
  end
end
