Rails.application.routes.draw do
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create' #C6  3. 9. 1　フォームの値を受け取る時のルーティング
  delete '/logout', to: 'sessions#destroy'
  

  
  resources :users do
  resources :tasks
    
  end
end