Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'home/index'
  root to: "home#index"
  resources :availabilities, except: [:show]

end