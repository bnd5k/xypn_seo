Rails.application.routes.draw do
  root 'websites#index', sort: 'mobile_desc'

  resources :websites, only: :index
end
