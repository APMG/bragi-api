# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wojxorfgax::Config do
  let(:config) { Wojxorfgax::Config.new }

  describe '#auth_plugin' do
    subject { config.auth_plugin }

    it 'has default' do
      is_expected.to be_kind_of Wojxorfgax::DefaultAuthPlugin
    end

    it 'round-trips' do
      config.auth_plugin = 'blah'
      expect(config.auth_plugin).to eq 'blah'
    end
  end
end
