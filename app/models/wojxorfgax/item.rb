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

    validates :audio_identifier, presence: true
    validates :audio_url, presence: true
    validates :audio_title, presence: true
    validates :source, presence: true
    validates :playtime, presence: true

    FIRST_ITEM_POSITION = 0
    MAX_ITEM_POSITION = 2_147_483_647
    MIN_ITEM_POSITION = -2_147_483_648
    POSITION_STEP = 10

    scope :sorted, ->(user_id) { where(wojxorfgax_user_id: user_id, status: %i[unplayed playing]).order(position: :asc) }

    before_save :set_position_after

    # TODO: Refactor all of this mess.
    def after
      @_after || (position.nil? ? nil : self.class.sorted(wojxorfgax_user_id).where('position < ?', position).reorder(position: :desc).first)
    end

    def after=(other_item)
      @_after = other_item || :first
    end

    private

    def set_position_after
      return if !@_after || played?

      if @_after == :first
        first_item = self.class.sorted(wojxorfgax_user_id).first
        self.position = if first_item
                          first_item.position - POSITION_STEP
                        else
                          FIRST_ITEM_POSITION
                        end
      elsif !@_after.played?
        raise AfterItemUnpersistedError, 'Item tried to be attached to unpersisted item' unless @_after.persisted?
        raise WrongUserAfterError, 'Item tried to be attached to item belonging to a different user' unless @_after.user == user
        start_position = @_after.position
        next_item = self.class.sorted(wojxorfgax_user_id).where('position > ?', start_position).reorder(position: :asc).first
        if next_item
          end_position = next_item.position
          if end_position - start_position > 1
            self.position = start_position + (end_position - start_position) / 2
          else
            self.class.resort(wojxorfgax_user_id)
            set_position_after
          end
        else
          self.position = start_position + POSITION_STEP
        end
      end

      @_after = nil
    end

    def self.resort(user_id)
      sorted(user_id).each_with_index do |item, idx|
        item.position = idx * POSITION_STEP
        item.save
      end
    end

    class AfterItemUnpersistedError < StandardError; end
    class WrongUserAfterError < StandardError; end
  end
end
