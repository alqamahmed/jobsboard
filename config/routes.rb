Rails.application.routes.draw do
  resources :applications
  resources :jobs
  devise_for :users
  # get 'home/index'
  # root 'home#index'
  root 'jobs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
