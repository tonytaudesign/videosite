Vs::Application.routes.draw do
  resources :searches

  resources :videos do
    member do
      post :add_comment
    end     
    new do
       post :upload
       get  :save_video
     end
  end

  get "authentications/google"
  match 'auth/google_oauth2/callback', :to => 'authentications#create', via: :get
  
  match 'upload-button', :to => 'videos#upload_button', via: [:get, :post], :as => :upload_button 
  match 'search-button', :to => 'videos#search_button', via: [:get, :post], :as => :search_button


  resources :videos, only: [:index, :new, :create]
  root to: 'videos#index'

end
