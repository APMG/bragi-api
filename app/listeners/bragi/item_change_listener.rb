require 'wisper'

module Bragi
  class ItemChangeListener
    include Wisper::Publisher

    def call(action, item)
      broadcast(:change, ItemAction.new(action, item))
    end
  end
end
