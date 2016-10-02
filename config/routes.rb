Rails.application.routes.draw do
  resources :reports
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/reset_cache', to: 'front#reset_cache'
  root 'front#index'
end
