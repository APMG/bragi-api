# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bragi do
  it 'is a thing' do
    expect(Bragi).to be_kind_of Module
  end

  describe '#config' do
    subject { Bragi.config }
    it { is_expected.to be_kind_of Bragi::Config }

    it 'calls block' do
      expect { |b| Bragi.config(&b) }.to yield_with_args
    end

    it 'passed config object inside block' do
      Bragi.config do |c|
        expect(c).to be_kind_of Bragi::Config
      end
    end
  end
end
