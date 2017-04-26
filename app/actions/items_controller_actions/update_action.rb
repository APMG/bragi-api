# frozen_string_literal: true

module Bragi
  module ItemsControllerActions
    class UpdateAction
      def initialize(context)
        @context = context
      end

      def render
        # See if it already exists.
        item = Item.find_by!(id: @context.params[:id], user: @context.current_user)
        item.attributes = permitted_params[:attributes]
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
          :type, attributes: %i[after audio_url audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
        )
      end
    end
  end
end
