# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wojxorfgax::UserSerializer do
  let(:user) { build :wojxorfgax_user, external_uid: '123456' }
  let(:serialization) { ActiveModelSerializers::SerializableResource.new(user).serializable_hash }

  it 'has three top level keys' do
    expect(serialization[:data].keys).to eq %i[id type attributes]
  end

  it 'passes through only the external_uid as the id' do
    expect(serialization[:data][:id]).to eq '123456'
  end

  it 'has only the secret uid as the attribute' do
    expect(serialization[:data][:attributes].keys).to eq %i[secret-uid]
  end
end
