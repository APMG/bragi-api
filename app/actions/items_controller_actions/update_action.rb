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
        update_attributes(item)

        if item.save
          ItemChangeListener.new.call(:update, item)
          # No render for 204 response.
        else
          @context.render json: item, status: :bad_request, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def permitted_params
        @context.params.require(:data).permit(
          :type, attributes: %i[after_id audio_url audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
        )
      end

      def update_attributes(item)
        item.attributes = permitted_params[:attributes]

        return unless item.played?
        item.finished = Time.zone.now if item.finished.nil?
        item.position = nil
      end
    end
  end
end
