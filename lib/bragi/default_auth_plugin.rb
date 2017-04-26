# frozen_string_literal: true

module Bragi
  class DefaultAuthPlugin
    # Null object plugin.

    def fetch_uid(_request)
      raise MissingAuthPluginError, 'You need to implement an Auth Plugin in order to use this engine'
    end

    class MissingAuthPluginError < StandardError; end
  end
end
