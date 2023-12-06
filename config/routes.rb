Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'

  resources :products, only: %i[index show], param: :code

  post :add_product, to: 'orders#add_product', path: 'orders/add_product'
  resources :orders, only: %i[index show], param: :uuid
end
