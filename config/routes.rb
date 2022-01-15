Rails.application.routes.draw do
  devise_for :users

  root 'goodies#home'

  get 'about' => 'goodies#about'
  get 'statistics' => 'goodies#statistics'

  post 'create_user' => 'users#create', as: :create_user
  resources :users, except: :create do
    resources :ideas, only: :index
  end

  resources :books, except: :show
  get 'loans' => 'books#outstanding_loans', as: :outstanding_loans
  get 'recent/new' => 'books#recently_created', as: :recently_created
  get 'recent/updated' => 'books#recently_updated', as: :recently_updated

  resources :collections, :languages, :publishers, :categories, :users, :genres, :colors, except: :show do
    resources :books, only: :index
  end

  resources :ideas, except: :show

  get 'google/search' => 'google#search'

  get 'amazon/search' => 'amazon#search'
  get 'amazon/robot' => 'amazon#robot'
  post 'amazon' => 'amazon#add_amazon_details', as: :add_amazon
  delete 'amazon/:id' => 'books#remove_amazon_details', as: :remove_amazon

  get 'backups' => 'backups#show'
  get 'backup/:file' => 'backups#download_sql', as: :download_sql
  get 'backup/zip/:file' => 'backups#download_zip', as: :download_zip
  post 'backup' => 'backups#new', as: :new_backup
  delete 'backup' => 'backups#remove', as: :remove_backup

  match "*path" => redirect('/'), via: :all
end
