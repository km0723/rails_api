Rails.application.routes.draw do
  resources :tests
  namespace 'api' do
    namespace 'v1' do
      resources :msgpacks
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
