# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wojxorfgax::UserSerializer do
  let(:item) { build :wojxorfgax_item, audio_identifier: '2014/01/01/blah' }
  let(:serialization) { ActiveModelSerializers::SerializableResource.new(item).serializable_hash }

  it 'has three top level keys' do
    expect(serialization[:data].keys).to eq %i[id type attributes]
  end

  it 'passes through only the audio_identifier as the id' do
    expect(serialization[:data][:id]).to eq '2014/01/01/blah'
  end

  it 'has an assumed set of attributes' do
    expect(serialization[:data][:attributes].keys).to eq %i[after audio-url audio-title audio-description audio-hosts audio-program origin-url source playtime status finished]
  end
end
