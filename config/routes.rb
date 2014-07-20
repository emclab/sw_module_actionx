SwModuleActionx::Engine.routes.draw do
  resources :module_actions
  
  root :to => 'module_actions#index'
end
