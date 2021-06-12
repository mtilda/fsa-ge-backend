Rails.application.routes.draw do
  resources :reports, only: [ :show ]
  resources :programs, only: [:index, :show ]
  resources :program_classifications, only: [:index, :show ]
  resources :institutions, only: [:index, :show ]
end
