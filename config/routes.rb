Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    registration: 'users/registrations'
  }

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    get 'users/profile', to: 'users#profile', as: :authenticated_profile
    get 'users/edit_avatar', to: 'users#edit_avatar', as: :edit_avatar
    patch 'users/update_avatar', to: 'users#update_avatar', as: :update_avatar
  # root "posts#index"
  end

  # Defines the root path route ("/")
  # root "posts#index"
  resources :bookings, only: [:index, :new, :create, :destroy]
  resources :pokemons, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:new, :create]
  end
  resources :users, only: [] do
    resources :bookings, only: [:index,]
  end
  get 'bookings/:id/accept', to: 'bookings#accept', as: :accept_booking
  get 'bookings/:id/reject', to: 'bookings#reject', as: :reject_booking
end
