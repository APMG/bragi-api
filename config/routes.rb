# frozen_string_literal: true

Bragi::Engine.routes.draw do
  resource :user, only: %i[show]
  resources :items
end
