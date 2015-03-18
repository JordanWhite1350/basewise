Rails.application.routes.draw do
  # Plural resources
  resources :projects
  # resources :users
  resources :users, only: [:edit, :update, :destroy]
  # Singular resources
  get "signin" => "session#new", as: "signin"
  post "login" => "session#create", as: "login"
  delete "logout" => "session#destroy", as: "logout"

  # Registration
  get "register" => "register#new", as: "register"
  post "register" => "register#create", as: "new_register"
end
