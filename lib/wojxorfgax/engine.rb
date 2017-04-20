# frozen_string_literal: true

module Wojxorfgax
  class Engine < ::Rails::Engine
    isolate_namespace Wojxorfgax
    config.generators.api_only = true

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.action_dispatch.rescue_responses['Wojxorfgax::ApplicationController::InvalidAuth'] = :forbidden
  end
end
