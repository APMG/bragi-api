# frozen_string_literal: true

module Wojxorfgax
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception

    before_action :authenticate_user

    attr_reader :current_user

    private

    def authenticate_user
      current_uid = Wojxorfgax.config.auth_plugin.fetch_uid(request)
      raise InvalidAuth, 'Invalid auth' if current_uid.nil?

      @current_user = User.find_or_create_by external_uid: current_uid
    end

    class InvalidAuth < StandardError; end

    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    end
  end
end
