# frozen_string_literal: true

module Bragi
  class UserSerializer < ActiveModel::Serializer
    attributes :secret_uid

    def id
      object.external_uid
    end
  end
end
