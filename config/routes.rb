Rails.application.routes.draw do
  resources :wallets
  resources :payments
  root "wallets#index"
end
