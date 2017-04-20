# frozen_string_literal: true

Wojxorfgax::Engine.routes.draw do
  resource :user, only: %i[show]
end
