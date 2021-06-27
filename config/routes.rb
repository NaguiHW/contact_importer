Rails.application.routes.draw do
  root    'sessions#new'
  get     '/importers', to: "importers#index"
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: "sessions#destroy"
  get     '/signup',    to: 'users#signup'
  post    '/signup',    to: 'users#create'
  post    '/importers', to: 'importers#create'
end
