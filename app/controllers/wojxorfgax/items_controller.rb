# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

require 'kaminari/core'
require 'kaminari/activerecord'

module Wojxorfgax
  class ItemsController < ApplicationController
    DEFAULT_PAGE_SIZE = 50

    Kaminari.configure do |config|
      config.max_per_page = 100
    end

    def index
      page_size = params.dig(:page, :size) || DEFAULT_PAGE_SIZE
      items = current_user.items.page(params.dig(:page, :number)).per(page_size)
      if params.dig(:filter, :source)
        items = items.where(source: params.dig(:filter, :source))
      end
      if params.dig(:filter, :status)
        items = items.where(status: params.dig(:filter, :status))
      end
      render json: items, meta: pagination_dict(items)
    end

    def show
      item = Item.find_by! id: params[:id], user: current_user
      render json: item
    end

    def update
      # See if it already exists.
      item = Item.find_by!(id: params[:id], user: current_user)
      update_params = permitted_params[:attributes]
      update_params.delete :audio_identifier
      item.attributes = update_params

      return if item.save
      render json: item, status: :bad_request, serializer: ActiveModel::Serializer::ErrorSerializer
    end

    def create
      # See if it already exists.
      item = Item.find_by(audio_identifier: permitted_params[:attributes][:audio_identifier], user: current_user) || Item.new
      item.attributes = permitted_params[:attributes]
      item.user = current_user

      if item.save
        render json: item
      else
        render json: item, status: :bad_request, serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    def destroy
      item = Item.find_by! id: params[:id], user: current_user
      item.destroy
    end

    private

    def permitted_params
      params.require(:data).permit(
        :type, attributes: %i[after audio_identifier audio_url audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
      )
    end
  end
end
