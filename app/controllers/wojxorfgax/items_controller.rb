# frozen_string_literal: true

require_dependency 'wojxorfgax/application_controller'

module Wojxorfgax
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
      UpdateAction.new(self).render
    end

    def create
      CreateAction.new(self).render
    end

    def destroy
      item = Item.find_by! id: params[:id], user: current_user
      item.destroy
    end

    class UpdateAction
      def initialize(context)
        @context = context
      end

      def render
        # See if it already exists.
        item = Item.find_by!(id: @context.params[:id], user: @context.current_user)
        update_params = permitted_params[:attributes]
        update_params.delete :audio_identifier
        item.attributes = update_params
        if item.played?
          item.finished = Time.zone.now if item.finished.nil?
          item.position = nil
        end

        return if item.save
        @context.render json: item, status: :bad_request, serializer: ActiveModel::Serializer::ErrorSerializer
      end

      private

      def permitted_params
        @context.params.require(:data).permit(
          :type, attributes: %i[after audio_identifier audio_url audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
        )
      end
    end

    class CreateAction
      def initialize(context)
        @context = context
      end

      def render
        # See if it already exists.
        item = Item.find_by(audio_identifier: permitted_params[:attributes][:audio_identifier], user: @context.current_user) || Item.new
        item.attributes = permitted_params[:attributes]
        item.user = @context.current_user

        if item.save
          @context.render json: item
        else
          @context.render json: item, status: :bad_request, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def permitted_params
        @context.params.require(:data).permit(
          :type, attributes: %i[after audio_identifier audio_url audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
        )
      end
    end
  end
end
