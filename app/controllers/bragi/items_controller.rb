# frozen_string_literal: true

require_dependency 'bragi/application_controller'

require 'items_controller_actions/create_action'
require 'items_controller_actions/update_action'

module Bragi
  class ItemsController < ApplicationController
    def index
      items = ItemIndexQuery.new(current_user.items, params).query
      render json: items, meta: pagination_dict(items)
    end

    def show
      item = Item.find_by! id: params[:id], user: current_user
      render json: item
    end

    def update
      ItemsControllerActions::UpdateAction.new(self).render
    end

    def create
      ItemsControllerActions::CreateAction.new(self).render
    end

    def destroy
      item = Item.find_by! id: params[:id], user: current_user
      item.destroy
    end
  end
end
