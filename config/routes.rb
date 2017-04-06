Rails.application.routes.draw do
    root "pages#home"
    get 'pages/home', to: 'pages#home'

    get '/articles', to: 'articles#index'
    #resources :articles
end
