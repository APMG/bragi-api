# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bragi::UserSerializer do
  let(:user) { build :bragi_user, external_uid: '123456', secret_uid: 'blah123' }
  let(:scope) do
    dbl_scope = double('scope')
    allow(dbl_scope).to receive_message_chain(:request, :base_url) { 'http://www.example.com' }

    dbl_scope
  end
  let(:serialization) { ActiveModelSerializers::SerializableResource.new(user, scope: scope).serializable_hash }

  it 'has three top level keys' do
    expect(serialization[:data].keys).to eq %i[id type attributes]
  end

  it 'passes through only the external_uid as the id' do
    expect(serialization[:data][:id]).to eq '123456'
  end

  it 'has only the podcast-url as the attribute' do
    expect(serialization[:data][:attributes].keys).to eq %i[podcast_url]
  end

  it 'has a reasonable value for the podcast-url' do
    expect(serialization[:data][:attributes][:podcast_url]).to eq 'http://www.example.com/items/blah123/podcast.xml'
  end
end
