# frozen_string_literal: true

require 'bragi/engine'
require 'bragi/config'

module Bragi
  def self.config
    @_config ||= Bragi::Config.new
    yield @_config if block_given?
    @_config
  end
end
