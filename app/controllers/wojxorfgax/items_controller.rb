# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

module Wojxorfgax
  class ItemsController < ApplicationController
    def index
      render json: current_user.items
    end

    def show
      item = Item.find_by! id: params[:id], user: current_user
      render json: [item]
    end

    def update; end
    def create; end

    def destroy
      item = Item.find_by! id: params[:id], user: current_user
      item.destroy
    end
  end
end
