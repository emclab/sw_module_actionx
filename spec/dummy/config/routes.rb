Rails.application.routes.draw do

  get "user_menus/index"

  mount SwModuleActionx::Engine => "/sw_module_actionx"
  mount SwModuleInfox::Engine => "/sw_module_infox"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount SwModuleInfox::Engine => '/module'
  mount Searchx::Engine => '/search'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
