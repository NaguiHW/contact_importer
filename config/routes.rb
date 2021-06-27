Rails.application.routes.draw do
  root    'sessions#new'
  get     '/importers',     to: "importers#index"
  post    '/login',         to: 'sessions#create'
  delete  '/logout',        to: "sessions#destroy"
  get     '/signup',        to: 'users#signup'
  post    '/signup',        to: 'users#create'
  post    '/importers',     to: 'importers#create'
  get     '/all_csvs',      to: 'importers#all_csvs'
  get     '/csv/:id',       to: 'importers#show'
  post    '/start_process', to: 'importers#start_process'
end
