# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bragi::UserSerializer do
  let(:item) { build :bragi_item, audio_identifier: '2014/01/01/blah' }
  let(:serialization) { ActiveModelSerializers::SerializableResource.new(item).serializable_hash }

  it 'has three top level keys' do
    expect(serialization[:data].keys).to eq %i[id type attributes]
  end

  it 'has an assumed set of attributes' do
    expect(serialization[:data][:attributes].keys).to eq %i[after audio-url audio-identifier audio-title audio-description audio-hosts audio-program origin-url source playtime status finished]
  end
end
