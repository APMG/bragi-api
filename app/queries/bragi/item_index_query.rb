# frozen_string_literal: true

require 'kaminari/core'
require 'kaminari/activerecord'

Kaminari.configure do |config|
  config.max_per_page = 100
  config.default_per_page = 50
end

module Bragi
  class ItemIndexQuery
    def initialize(relation, params)
      @relation = relation
      @params = params
    end

    def query
      @relation.page(page_number).per(page_size)
               .where(where_clause)
               .order('-position DESC').order(finished: :asc) # Special MySQL syntax to get the nulls last
    end

    private

    def where_clause
      hsh = {}
      hsh[:source] = source_filter if source_filter
      hsh[:status] = status_filter if status_filter
      hsh[:audio_identifier] = audio_identifier_filter if audio_identifier_filter

      hsh
    end

    def source_filter
      @params.dig(:filter, :source)
    end

    def status_filter
      @params.dig(:filter, :status)
    end

    def audio_identifier_filter
      @params.dig(:filter, :audio_identifier)
    end

    def page_size
      @params.dig(:page, :size)
    end

    def page_number
      @params.dig(:page, :number)
    end
  end
end
