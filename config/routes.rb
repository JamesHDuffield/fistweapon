Rails.application.routes.draw do
  get 'front/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'front/index'
  root 'front#index'
end
