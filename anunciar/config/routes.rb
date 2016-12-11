Rails.application.routes.draw do
  devise_for :admins
  devise_for :students
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :announcements
  root 'announcements#index'
  namespace :api, defaults: {format: 'json'} do
  	namespace :v1 do
  		resources :announcements
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
