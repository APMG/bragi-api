# frozen_string_literal: true

Bragi::Engine.routes.draw do
  # Handle CORS options request
  match '*path', via: [:options], controller: 'application', action: 'handle_options_request'

  resource :user, only: %i[show]
  resources :items do
    get :podcast
  end
end
