# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

module Wojxorfgax
  class UsersController < ApplicationController
    def show
      render json: [current_user]
    end
  end
end
