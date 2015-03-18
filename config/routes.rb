Rails.application.routes.draw do
  resources :projects
  resources :users, only: [:edit, :update, :destroy]
  resources :todo_lists, only: [:create, :update, :destroy, :show]

  # Session
  get "signin" => "session#new", as: "signin"
  post "login" => "session#create", as: "login"
  delete "logout" => "session#destroy", as: "logout"

  # Registration
  get "register" => "register#new", as: "register"
  post "register" => "register#create", as: "new_register"
end
