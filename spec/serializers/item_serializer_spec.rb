# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bragi::ItemSerializer do
  let(:item) { build :bragi_item, audio_identifier: '2014/01/01/blah', id: 'test' }
  let(:serializer) { Bragi::ItemSerializer.new(item) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer).as_json }

  it 'has three top level keys' do
    expect(serialization[:data].keys).to eq %i[id type attributes]
  end

  it 'has an assumed set of attributes' do
    expect(serialization[:data][:attributes].keys).to eq %i[after_id audio_url audio_identifier audio_title audio_description audio_hosts audio_program origin_url source playtime status finished]
  end
end
