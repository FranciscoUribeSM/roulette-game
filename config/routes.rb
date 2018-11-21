Rails.application.routes.draw do
  root 'rounds#index'
  resources :players
  resources :players

end


