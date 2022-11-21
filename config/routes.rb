Rails.application.routes.draw do
  resources :wallets
  resources :payments
  root "payments#new"
end
