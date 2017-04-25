# frozen_string_literal: true

require 'active_model_serializers'

module Wojxorfgax
  class Engine < ::Rails::Engine
    isolate_namespace Wojxorfgax
    config.generators.api_only = true

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.action_dispatch.rescue_responses['Wojxorfgax::ApplicationController::InvalidAuth'] = :forbidden

    ActiveModelSerializers.config.adapter = :json_api

    api_mime_types = %w[
      application/vnd.api+json
      text/x-json
      application/json
    ]
    Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
  end
end
