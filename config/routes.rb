Rails.application.routes.draw do
  root 'recipes#index'
  resources :recipes
  get '/search', to: "recipes#search"
end
