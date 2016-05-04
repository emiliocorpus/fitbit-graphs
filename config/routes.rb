Rails.application.routes.draw do

  get 'user/index'

  get 'user/new'

  get 'user/login'

  get 'user/logout'

  
  # You can have the root of your site routed with "root"
  root 'page#home'

  get 'user/:id' => 'page#user'

  
end
