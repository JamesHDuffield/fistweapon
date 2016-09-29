Rails.application.routes.draw do
  post '/reports', to: 'reports#create'
  get '/reports/new', to: 'reports#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'reports/members_list', to: 'reports#members_list'
  get '/reset_cache', to: 'front#reset_cache'
  root 'front#index'
end
