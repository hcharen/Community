Rails.application.routes.draw do

  devise_for :users
  # makes the url /items, instead of /items/index
  get 'items', to: 'item#index'
  # root to the item#index
  root 'welcome#index'
  # item create method happens on index,
  post 'items', to: 'item#create'
  # get the route to the show page for each individual item
  get 'items/:id', to: 'item#show', as: 'item'

  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
