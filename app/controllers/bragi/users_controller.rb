# frozen_string_literal: true

require_dependency 'bragi/application_controller'

module Bragi
  class UsersController < ApplicationController
    def show
      render json: current_user, scope: self
    end
  end
end
