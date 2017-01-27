Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :v1, defaults: { format: :json } do
    devise_for :students, only: []
    resource :login, only: [:create], controller: :sessions
    resources :students, only: [:create]
    resources :announcements, only: [:index, :show, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
