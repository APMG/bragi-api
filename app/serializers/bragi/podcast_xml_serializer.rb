# frozen_string_literal: true

require 'builder'

module Bragi
  class PodcastXmlSerializer
    def initialize(items)
      @items = items
    end

    def to_xml(_args)
      builder = Builder::XmlMarkup.new
      builder.instruct! :xml, version: '1.0', encoding: 'UTF-8'
      builder.rss version: '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/', 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd' do |rss_builder|
        rss_builder.channel do |channel_builder|
          channel_builder.title 'Custom Podcast'
          # </link>
          # </description>
          # <language>en</language>
          # <itunes:author></itunes:author>
          # <itunes:subtitle></itunes:subtitle>

          @items.each { |item| serialize_item(channel_builder, item) }
        end
      end
    end

    private

    def serialize_item(builder, item)
      builder.item do |item_builder|
        item_builder.title item.audio_title
        item_builder.description item.audio_description
        item_builder.link item.origin_url
        item_builder.guid item.audio_identifier, 'isPermaLink' => 'false'
        item_builder.enclosure url: item.audio_url # length: "4130451" type: "audio/mpeg"
        # item_builder.pubDate 'Tue, 28 Mar 2017 13:15:00 +0000'
      end
    end
  end
end
