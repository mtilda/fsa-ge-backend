Rails.application.routes.draw do
  resources :reports
  resources :programs
  resources :program_classifications
  resources :institutions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
