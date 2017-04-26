# frozen_string_literal: true

require 'kaminari/core'
require 'kaminari/activerecord'

Kaminari.configure do |config|
  config.max_per_page = 100
  config.default_per_page = 50
end

module Wojxorfgax
  class ItemIndexQuery
    def initialize(relation, params)
      @relation = relation
      @params = params
    end

    def query
      items = @relation.page(page_number).per(page_size)
      items = items.where(source: source_filter) if source_filter
      items = items.where(status: status_filter) if status_filter
      # Special MySQL syntax to get the nulls last
      items = items.order('-position DESC').order(finished: :asc)

      items
    end

    private

    def source_filter
      @params.dig(:filter, :source)
    end

    def status_filter
      @params.dig(:filter, :status)
    end

    def page_size
      @params.dig(:page, :size)
    end

    def page_number
      @params.dig(:page, :number)
    end
  end
end
