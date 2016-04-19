Rails.application.routes.draw do

  devise_for :users
  root 'chats#index'
  post '/new_message' => 'chats#new_message', :as => :new_message
  get '/refresh_chats' => 'chats#refresh_chats', :as => :refresh_chats
  get '/refresh_users' => 'chats#refresh_users', :as => :refresh_users
  get '/exit_chat' => 'chats#exit_chat', :as => :exit_chat
  resources 'chats' do

    resources 'messages' do
      collection do
        post :import
        # get :autocomplete # <= add this line
      end
    end
  end
  get '/messages/autocomplete' => 'messages#autocomplete'
  get '/search' => 'messages#search', as: 'search'

  post '/payload' => 'messages#payload'
  #

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
