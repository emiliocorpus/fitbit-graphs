Rails.application.routes.draw do
  
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  # You can have the root of your site routed with "root"
  root 'page#home'

  get 'user/:id' => 'page#user'

  get 'fitbit/:resource/:date.json' => 'fitbit_api#data_request', as: 'fitbit_api_request'
  
end
