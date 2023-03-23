Rails.application.routes.draw do
  resources :recipes, only: [:index, :create]
  post '/signup', to: 'users#create'
  get '/me', to: 'users#me'
  get '/recipes', to: 'recipes#index'
  post '/recipes', to: 'recipes#create'
  post'/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'

end
