# frozen_string_literal: true

module Bragi
  class ItemSerializer < ActiveModel::Serializer
    attributes :after_id, :audio_url, :audio_identifier, :audio_title, :audio_description, :audio_hosts, :audio_program, :origin_url, :source, :playtime, :status, :finished
  end
end
