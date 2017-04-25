# frozen_string_literal: true

# == Schema Information
#
# Table name: wojxorfgax_items
#
#  id                 :integer          not null, primary key
#  sort               :float(24)
#  audio_identifier   :string(255)      not null
#  audio_url          :string(255)      not null
#  audio_title        :string(255)      not null
#  audio_description  :text(65535)
#  audio_hosts        :text(65535)
#  audio_program      :string(255)
#  origin_url         :string(255)
#  source             :string(255)      not null
#  playtime           :integer          not null
#  status             :integer          not null
#  finished           :datetime
#  wojxorfgax_user_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Wojxorfgax
  class Item < ApplicationRecord
    belongs_to :user, foreign_key: :wojxorfgax_user_id
    enum status: { unplayed: 0, playing: 1, played: 2 }

    validates :finished, absence: true, unless: :played?
    validates :finished, presence: true, if: :played?

    validates :position, absence: true, if: :played?
    # validates :position, presence: true, unless: :played?

    validates :audio_identifier, presence: true
    validates :audio_url, presence: true
    validates :audio_title, presence: true
    validates :source, presence: true
    validates :playtime, presence: true

    scope :sorted, ->(user_id) { where(wojxorfgax_user_id: user_id, status: %i[unplayed playing]).order(position: :asc) }

    before_save :set_position_after

    delegate :after, to: :position_tracker
    delegate :after=, to: :position_tracker

    private

    def position_tracker
      @_position_tracker ||= PositionTracker.new(self)
    end

    def set_position_after
      self.position = if played?
                        nil
                      else
                        position_tracker.position
      end
    end

    def self.resort(user_id)
      sorted(user_id).each_with_index do |item, idx|
        item.position = idx * PositionTracker::POSITION_STEP
        item.save
      end
    end

    class AfterItemUnpersistedError < StandardError; end
    class WrongUserAfterError < StandardError; end
  end
end
