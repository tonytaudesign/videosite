Vs::Application.routes.draw do
  get "pages/upload_form"
  post "videos/create"
  resources :searches
  post "videos/search"
  resources :videos do
    member do
      post :add_comment
    end     
    new do
       post :upload
       get  :save_video
     end
  end

  get 'videos/upload_form'

  get "authentications/google"
  match 'auth/google_oauth2/callback', :to => 'authentications#create', via: :get
  
  match 'upload-button', :to => 'videos#upload_button', via: [:get, :post], :as => :upload_button 
  match 'search-button', :to => 'videos#search_button', via: [:get, :post], :as => :search_button


  resources :videos, only: [:index, :new]
  root to: 'videos#index'

end
