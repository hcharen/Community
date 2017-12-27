Rails.application.routes.draw do

  # makes the url /items, instead of /items/index
  get 'items', to: 'item#index'
  # root to the item#index
  root 'item#index'
  # item create method happens on index,
  post 'items', to: 'item#create'
  # get the route to the show page for each individual item
  get 'items/:id', to: 'item#show', as: 'item'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
