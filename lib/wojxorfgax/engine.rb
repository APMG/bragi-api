# frozen_string_literal: true

module Wojxorfgax
  class Engine < ::Rails::Engine
    isolate_namespace Wojxorfgax
    config.generators.api_only = true
  end
end
