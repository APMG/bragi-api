# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

module Wojxorfgax
  class UsersController < ApplicationController
    def show
      user = User.find_by! external_uid: current_uid
      render json: { external_uid: user.external_uid, secret_uid: user.secret_uid }
    end
  end
end
