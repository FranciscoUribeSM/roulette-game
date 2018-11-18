Rails.application.routes.draw do
  root 'rounds#index'
  resources :players
  resources :players

  #Test request to create rounds manually
  get 'test-new-round', to:'rounds#new_round'
  get 'bonus', to:'players#bonus'
end


