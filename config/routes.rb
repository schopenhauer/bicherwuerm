Rails.application.routes.draw do
  devise_for :users

  root 'goodies#home'

  resources :users, except: :create
  post 'create_user' => 'users#create', as: :create_user

  resources :books
  resources :ideas

  resources :collections, :languages, :publishers, :categories, :users, :genres, :colors do
    resources :books, only: [:index]
  end

  get 'amazon/add' => 'amazon#add_amazon_details', as: :add_amazon
  post 'books/reset/:id' => 'books#remove_amazon_details', as: :remove_amazon

  get 'about' => 'goodies#about'
  get 'loans' => 'books#loans'
  get 'statistics' => 'goodies#statistics'

  get 'google/search' => 'google#search'
  get 'amazon/search' => 'amazon#search'
  get 'amazon/robot' => 'amazon#robot'

  get 'backups' => 'backups#show'
  post 'backups/new' => 'backups#new', as: :new_backup
  delete 'backups' => 'backups#remove', as: :remove_backup
  get 'backups/:file' => 'backups#download_sql', as: :download_sql
  get 'backups/zip/:file' => 'backups#download_zip', as: :download_zip

  match "*path" => redirect('/'), via: :all
end
