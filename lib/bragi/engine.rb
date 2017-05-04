# frozen_string_literal: true

require 'active_model_serializers'
require 'rack/cors'

module Bragi
  class Engine < ::Rails::Engine
    isolate_namespace Bragi
    config.generators.api_only = true

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.action_dispatch.rescue_responses['Bragi::ApplicationController::InvalidAuth'] = :forbidden

    ActiveModelSerializers.config.adapter = :json_api

    api_mime_types = %w[
      application/vnd.api+json
      text/x-json
      application/json
    ]
    Mime::Type.register 'application/vnd.api+json', :json, api_mime_types

    # CORS Headers
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :patch, :delete, :options, :put]
      end
    end
  end
end
