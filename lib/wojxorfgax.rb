# frozen_string_literal: true

require 'wojxorfgax/engine'
require 'wojxorfgax/config'

module Wojxorfgax
  def self.config
    @_config ||= Wojxorfgax::Config.new
    yield @_config if block_given?
    @_config
  end
end
