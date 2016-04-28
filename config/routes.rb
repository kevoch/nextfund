Rails.application.routes.draw do

 # See how all your routes lay out with "rake routes".
  # devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks" }
  # resources :projects
  post 'homepage/shuffle' => 'homepage#shuffle'

  get 'activities/index'

 post 'search', to: 'search#search'
 get 'search', to: 'search#search'

  get 'projects/education'

  get 'transactions/new'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
 # See how all your routes lay out with "rake routes".

  resources :projects do
    member do
      put 'like', to: "projects#upvote"
      put 'dislike', to: "projects#downvote"
    end
  end



  resources :users

  match 'users/:id' => 'users#show', via: :get

  resources :transactions, only: [:new, :create]

  resources :activities


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
  root 'homepage#index'

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
