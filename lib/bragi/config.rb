# frozen_string_literal: true

require 'bragi/default_auth_plugin'

module Bragi
  class Config
    attr_accessor :auth_plugin

    def initialize
      # Defaults
      @auth_plugin = Bragi::DefaultAuthPlugin.new
    end
  end
end
