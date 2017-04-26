# frozen_string_literal: true

require 'rails_helper'

require 'bragi/default_auth_plugin'

RSpec.describe Bragi::DefaultAuthPlugin do
  let(:auth_plugin) { Bragi::DefaultAuthPlugin.new }

  describe '#fetch_uid' do
    subject { auth_plugin.fetch_uid(nil) }

    it 'returns exception' do
      expect { subject }.to raise_exception Bragi::DefaultAuthPlugin::MissingAuthPluginError
    end
  end
end
