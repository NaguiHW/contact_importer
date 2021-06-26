Rails.application.routes.draw do
  root "users#login"
  get '/signup', to: "users#signup"
  post '/signup', to: "users#create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
