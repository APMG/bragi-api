# frozen_string_literal: true

module Bragi
  class ItemAction
    attr_reader :action, :item

    def initialize(action, item)
      @action = action
      @item = item
    end

    def to_json
      serializer = Bragi::ItemSerializer.new(item)
      {
        action: action,
        data: ActiveModelSerializers::Adapter.create(serializer).as_json[:data]
      }
    end
  end
end
