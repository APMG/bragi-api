# frozen_string_literal: true

module Bragi
  module ItemsControllerActions
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
