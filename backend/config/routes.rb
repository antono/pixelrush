# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :pixels do
    post :create_bulk, on: :collection
  end

  resource :session, only: [:new, :create, :destroy] do
    post :callback
  end

  resource :registration, only: [:new, :create] do
    post :callback
  end

  resources :credentials, only: [:create, :destroy] do
    post :callback, on: :collection
  end

  # post "session_callback", to: "sessions#callback"
  # post "registration_callback", to: "registrations#callback"
  root to: "home#index"
end
