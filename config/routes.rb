Rails.application.routes.draw do

  root 'welcome#index'

  resource :welcome, only: :index
  
end
