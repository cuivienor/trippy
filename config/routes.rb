Rails.application.routes.draw do


  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get '/welcome/search', to: 'welcome#search'
  
  get '/sessions/new', to: 'sessions#new', as: :new_sessions
  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'
  get '/sessions', to: 'sessions#autoLogIn'

  resources :users do
    resources :locations do
      resources :trips
      resources :pois
    end
  end

end




  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

resources :users do
  resources :locations do
    resources :pois
    resources :trips
  end
end

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



#                  Prefix Verb   URI Pattern                                                     Controller#Action
#     user_location_trips GET    /users/:user_id/locations/:location_id/trips(.:format)          trips#index
#                         POST   /users/:user_id/locations/:location_id/trips(.:format)          trips#create
#  new_user_location_trip GET    /users/:user_id/locations/:location_id/trips/new(.:format)      trips#new
# edit_user_location_trip GET    /users/:user_id/locations/:location_id/trips/:id/edit(.:format) trips#edit
#      user_location_trip GET    /users/:user_id/locations/:location_id/trips/:id(.:format)      trips#show
#                         PATCH  /users/:user_id/locations/:location_id/trips/:id(.:format)      trips#update
#                         PUT    /users/:user_id/locations/:location_id/trips/:id(.:format)      trips#update
#                         DELETE /users/:user_id/locations/:location_id/trips/:id(.:format)      trips#destroy
#      user_location_pois GET    /users/:user_id/locations/:location_id/pois(.:format)           pois#index
#                         POST   /users/:user_id/locations/:location_id/pois(.:format)           pois#create
#   new_user_location_poi GET    /users/:user_id/locations/:location_id/pois/new(.:format)       pois#new
#  edit_user_location_poi GET    /users/:user_id/locations/:location_id/pois/:id/edit(.:format)  pois#edit
#       user_location_poi GET    /users/:user_id/locations/:location_id/pois/:id(.:format)       pois#show
#                         PATCH  /users/:user_id/locations/:location_id/pois/:id(.:format)       pois#update
#                         PUT    /users/:user_id/locations/:location_id/pois/:id(.:format)       pois#update
#                         DELETE /users/:user_id/locations/:location_id/pois/:id(.:format)       pois#destroy
#          user_locations GET    /users/:user_id/locations(.:format)                             locations#index
#                         POST   /users/:user_id/locations(.:format)                             locations#create
#       new_user_location GET    /users/:user_id/locations/new(.:format)                         locations#new
#      edit_user_location GET    /users/:user_id/locations/:id/edit(.:format)                    locations#edit
#           user_location GET    /users/:user_id/locations/:id(.:format)                         locations#show
#                         PATCH  /users/:user_id/locations/:id(.:format)                         locations#update
#                         PUT    /users/:user_id/locations/:id(.:format)                         locations#update
#                         DELETE /users/:user_id/locations/:id(.:format)                         locations#destroy
#                   users GET    /users(.:format)                                                users#index
#                         POST   /users(.:format)                                                users#create
#                new_user GET    /users/new(.:format)                                            users#new
#               edit_user GET    /users/:id/edit(.:format)                                       users#edit
#                    user GET    /users/:id(.:format)                                            users#show
#                         PATCH  /users/:id(.:format)                                            users#update
#                         PUT    /users/:id(.:format)                                            users#update
#                         DELETE /users/:id(.:format)                                            users#destroy
