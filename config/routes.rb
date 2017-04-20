# frozen_string_literal: true

Wojxorfgax::Engine.routes.draw do
  resource :user, only: %i[show]
  resources :items do
    get '*id' => 'items#show', on: :collection
  end
end
