# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wojxorfgax do
  it 'is a thing' do
    expect(Wojxorfgax).to be_kind_of Module
  end

  describe '#config' do
    subject { Wojxorfgax.config }
    it { is_expected.to be_kind_of Wojxorfgax::Config }

    it 'calls block' do
      expect { |b| Wojxorfgax.config(&b) }.to yield_with_args
    end

    it 'passed config object inside block' do
      Wojxorfgax.config do |c|
        expect(c).to be_kind_of Wojxorfgax::Config
      end
    end
  end
end
