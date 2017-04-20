module Wojxorfgax
  class ItemSerializer < ActiveModel::Serializer
    attributes :after, :audio_url, :audio_title, :audio_description, :audio_hosts, :audio_program, :origin_url, :source, :playtime, :status, :finished

    def id
      object.audio_identifier
    end

    def after
      'todo'
    end
  end
end
