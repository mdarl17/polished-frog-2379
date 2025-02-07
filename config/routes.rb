Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :doctors, only: :show do
    resources :patient_doctors, only: :destroy
  end

  resources :hospitals, only: :show

  resources :patients, only: :index
end
