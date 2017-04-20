# frozen_string_literal: true

require 'wojxorfgax/default_auth_plugin'

module Wojxorfgax
  class Config
    attr_accessor :auth_plugin

    def initialize
      # Defaults
      @auth_plugin = Wojxorfgax::DefaultAuthPlugin.new
    end
  end
end
