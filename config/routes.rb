Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :schedules, only: [:index]
  resources :stats, only: [:index]
  resources :scores, only: [:index]
end
