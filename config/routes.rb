Rails.application.routes.draw do
  root    'sessions#new'
  get     '/importers', to: "importers#index"
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: "sessions#destroy"
  get     '/signup',    to: 'users#signup'
  post    '/signup',    to: 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
