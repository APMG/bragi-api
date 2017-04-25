# frozen_string_literal: true

module Wojxorfgax
  class PositionTracker
    class UnchangedTracker
      def initialize(item)
        @item = item
      end

      def after
        return if @item.position.nil?
        Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).where('position < ?', @item.position).reorder(position: :desc).first
      end

      def position
        # Default to last
        if @item.position.nil?
          last_item = Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).last
          if last_item
            last_item.position + PositionTracker::POSITION_STEP
          else
            PositionTracker::FIRST_ITEM_POSITION
          end
        else
          @item.position
        end
      end
    end
  end
end
