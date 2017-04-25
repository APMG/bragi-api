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
        check_valid_after

        return if @after.played?

        return start_position + PositionTracker::POSITION_STEP unless next_item

        if available_distance > 1
          start_position + available_distance / 2
        else
          # REFACTOR: This next line makes this query potentially have a
          # side-affect. That breaks CQS.
          Wojxorfgax::Item.resort(@item.wojxorfgax_user_id)
          position # Recursive
        end
      end

      private

      def start_position
        # Make the algorithm more readable.
        @after.position
      end

      def end_position
        # Make the algorithm more readable.
        next_item.position
      end

      def available_distance
        end_position - start_position
      end

      def check_valid_after
        raise Item::AfterItemUnpersistedError, 'Item tried to be attached to unpersisted item' unless @after.persisted?
        raise Item::WrongUserAfterError, 'Item tried to be attached to item belonging to a different user' unless @after.user == @item.user
      end

      def next_item
        Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).where('position > ?', start_position).reorder(position: :asc).first
      end
    end
  end
end
