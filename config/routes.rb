Rails.application.routes.draw do
    # get '/articles', to: 'articles#index'
    post 'login', to: 'access_tokens#create'
    resources :articles, only: %i[index show]
end
