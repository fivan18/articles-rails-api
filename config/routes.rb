Rails.application.routes.draw do
  # get '/articles', to: 'articles#index'
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'

  resources :articles do
    resources :comments, only: %i[index create]
  end
end
