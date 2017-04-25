# frozen_string_literal: true

module Wojxorfgax
  class PositionTracker
    class AfterTracker
      attr_reader :after

      def initialize(item, after)
        @item = item
        @after = after
      end

      def position
        raise Item::AfterItemUnpersistedError, 'Item tried to be attached to unpersisted item' unless @after.persisted?
        raise Item::WrongUserAfterError, 'Item tried to be attached to item belonging to a different user' unless @after.user == @item.user

        return if @after.played?

        start_position = @after.position
        next_item = Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).where('position > ?', start_position).reorder(position: :asc).first
        if next_item
          end_position = next_item.position
          if end_position - start_position > 1
            return start_position + (end_position - start_position) / 2
          else
            # REFACTOR: This next line makes this query potentially have a
            # side-affect. That breaks CQS.
            Wojxorfgax::Item.resort(@item.wojxorfgax_user_id)
            return position # Recursive
          end
        else
          return start_position + PositionTracker::POSITION_STEP
        end
      end
    end
  end
end
