Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/activities', to: 'activities#index'
      get '/backgrounds', to: 'backgrounds#index'
    end
  end
end
