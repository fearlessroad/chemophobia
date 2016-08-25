Rails.application.routes.draw do

  get 'admins/index'

  root 'application#index'
  get 'application/index'=>'application#index'
  get '/admins' => 'admins#index'

  # application
  get '/items'=> 'items#index'
  get '/items/index'=> 'items#index'
  get 'items/display/:id'=>'items#display'

  # adding items
  post '/items' => 'items#create'
  post '/items/destroy/:id' =>'items#destroy'
  post '/items/reset' => 'items#reset'
  patch '/items' => 'items#update'
  post '/items/confirm' => 'items#confirm'
  post '/items/edit'=>'items#edit'

  # admin and sessions
  post '/admins' => 'admins#login'
  get '/items/new' => 'items#new'
  delete '/admins' => 'admins#destroy'
  post '/admins/item'=>'admins#item'
  post '/admins/chemical'=>'admins#chemical'

  # adding chemicals
  post '/chemicals'=>'chemicals#create'
  post '/chemicals/resetSession'=>'chemicals#resetSession'
  get '/chemicals/new'=>'chemicals#new'
  post '/chemicals/:id' => 'chemicals#getInfo'
  get '/chemicals/:id' => 'chemicals#getInfo'
  patch '/chemicals' => 'chemicals#update'

  # adding categories
  post '/categories'=>'categories#create'
  post '/categories/selectCat' => 'categories#selectCat'
  post '/categories/confirm' => 'categories#confirm'
  get '/categories/new'=>'categories#new'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
