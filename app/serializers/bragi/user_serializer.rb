# frozen_string_literal: true

module Bragi
  class UserSerializer < ActiveModel::Serializer
    attributes :podcast_url

    def id
      object.external_uid
    end

    def podcast_url
      "#{scope.request.base_url}/items/#{object.secret_uid}/podcast.xml"
    end
  end
end
