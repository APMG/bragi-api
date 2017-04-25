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

    def after
      position_tracker.after
    end

    def after=(other_item)
      position_tracker.after = other_item
    end

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

    class PositionTracker
      FIRST_ITEM_POSITION = 0
      MAX_ITEM_POSITION = 2_147_483_647
      MIN_ITEM_POSITION = -2_147_483_648
      POSITION_STEP = 10

      def initialize(item)
        @item = item
        init_tracker
      end

      def after=(other_item)
        @internal_tracker = if other_item.nil?
          FirstTracker.new(@item)
        else
          AfterTracker.new(@item, other_item)
        end
      end

      def after
        @internal_tracker.after
      end

      def position
        @internal_tracker.position.tap do
          init_tracker
        end
      end

      private

      def init_tracker
        @internal_tracker = UnchangedTracker.new(@item)
      end

      class FirstTracker
        def initialize(item)
          @item = item
        end

        def position
          first_item = Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).first
          if first_item
            first_item.position - PositionTracker::POSITION_STEP
          else
            PositionTracker::FIRST_ITEM_POSITION
          end
        end
      end

      class AfterTracker
        attr_reader :after

        def initialize(item, after)
          @item = item
          @after = after
        end

        def position
          raise AfterItemUnpersistedError, 'Item tried to be attached to unpersisted item' unless @after.persisted?
          raise WrongUserAfterError, 'Item tried to be attached to item belonging to a different user' unless @after.user == @item.user

          return if @after.played?

          start_position = @after.position
          next_item = Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).where('position > ?', start_position).reorder(position: :asc).first
          if next_item
            end_position = next_item.position
            if end_position - start_position > 1
              return start_position + (end_position - start_position) / 2
            else
              # REFACTOR: This next line makes this query potentially have a
              # side-affect. That breaks CQS.
              Wojxorfgax::Item.resort(@item.wojxorfgax_user_id)
              return position # Recursive
            end
          else
            return start_position + PositionTracker::POSITION_STEP
          end
        end
      end

      class UnchangedTracker
        def initialize(item)
          @item = item
        end

        def after
          return if @item.position.nil?
          Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).where('position < ?', @item.position).reorder(position: :desc).first
        end

        def position
          # Default to last
          if @item.position.nil?
            last_item = Wojxorfgax::Item.sorted(@item.wojxorfgax_user_id).last
            if last_item
              last_item.position + PositionTracker::POSITION_STEP
            else
              PositionTracker::FIRST_ITEM_POSITION
            end
          else
            @item.position
          end
        end
      end
    end
  end
end
