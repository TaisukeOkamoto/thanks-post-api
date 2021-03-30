Rails.application.routes.draw do
  resources :users
  resources :posts, :only => [:create, :destroy, :update]
  get '/user/:id/posts', to: 'posts#user_posts'
  root to:'pages#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
