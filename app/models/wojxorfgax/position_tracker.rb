# frozen_string_literal: true

module Wojxorfgax
  class PositionTracker
    FIRST_ITEM_POSITION = 0
    MAX_ITEM_POSITION = 2_147_483_647
    MIN_ITEM_POSITION = -2_147_483_648
    POSITION_STEP = 10

    def initialize(item)
      @item = item
      init_tracker
    end

    def after=(other_item)
      @internal_tracker = if other_item.nil?
                            FirstTracker.new(@item)
                          else
                            AfterTracker.new(@item, other_item)
                          end
    end

    def after
      @internal_tracker.after
    end

    def position
      @internal_tracker.position.tap do
        init_tracker
      end
    end

    private

    def init_tracker
      @internal_tracker = UnchangedTracker.new(@item)
    end
  end
end
