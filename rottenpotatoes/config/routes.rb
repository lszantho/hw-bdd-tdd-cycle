Rottenpotatoes::Application.routes.draw do
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  # root 'movies#index'
  
  resources :movies do
    get 'director'
  end
  
end

