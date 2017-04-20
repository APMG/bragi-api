# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

module Wojxorfgax
  class ItemsController < ApplicationController
    def index
      render json: current_user.items
    end

    def show; end
    def update; end
    def create; end
    def destroy; end
  end
end
