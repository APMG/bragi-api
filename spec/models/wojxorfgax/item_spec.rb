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

require 'rails_helper'

module Wojxorfgax
  RSpec.describe Item, type: :model do
    let(:user) { create :wojxorfgax_user }
    let(:status) { :unplayed }
    let(:item) { build :wojxorfgax_item, status: status, user: user }

    describe '#finished' do
      context 'with played status' do
        let(:status) { :played }

        it 'allows a finished datetime' do
          item.finished = Time.zone.now
          expect(item).to be_valid
        end
      end

      (Item.statuses.keys - ['played']).each do |enum_status|
        context "with #{enum_status} status" do
          let(:status) { enum_status }

          it 'does not allow a finished datetime' do
            item.finished = Time.zone.now
            expect(item).to_not be_valid
          end
        end
      end
    end
  end
end
