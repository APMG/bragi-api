# frozen_string_literal: true

require 'rails_helper'

require 'wojxorfgax/default_auth_plugin'

RSpec.describe Wojxorfgax::DefaultAuthPlugin do
  let(:auth_plugin) { Wojxorfgax::DefaultAuthPlugin.new }

  describe '#fetch_uid' do
    subject { auth_plugin.fetch_uid(nil) }

    it 'returns exception' do
      expect { subject }.to raise_exception Wojxorfgax::DefaultAuthPlugin::MissingAuthPluginError
    end
  end
end
