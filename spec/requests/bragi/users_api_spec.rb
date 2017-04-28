# frozen_string_literal: true

require 'rails_helper'

require 'support/mock_auth_plugin'

module Bragi
  RSpec.describe 'Users API', type: :request do
    before :each do
      Bragi.config do |c|
        c.auth_plugin = MockAuthPlugin.new
      end
    end

    describe 'GET #show' do
      context 'with existing user' do
        let!(:user) { create :bragi_user, external_uid: '12345', secret_uid: 'blah1234' }

        it 'returns http success' do
          get '/user', headers: { 'Authorization' => 'authorized_user' }
          expect(response).to have_http_status(200)

          json = JSON.parse response.body
          expect(json['data']['id']).to eq '12345'
          expect(json['data'].keys).to eq %w[id type attributes]
          expect(json['data']['type']).to eq 'bragi-users'
          expect(json['data']['attributes'].keys).to eq %w[podcast-url]
          expect(json['data']['attributes']['podcast-url']).to eq 'http://www.example.com/items/blah1234/podcast.xml'
        end
      end

      context 'without existing user' do
        it 'creates user when it does not already have one' do
          get '/user', headers: { 'Authorization' => 'authorized_user' }
          expect(response).to have_http_status(200)

          json = JSON.parse response.body
          expect(json['data']['id']).to eq '12345'
          expect(json['data'].keys).to eq %w[id type attributes]
          expect(json['data']['type']).to eq 'bragi-users'
        end
      end

      it 'returns error on unauthenticated response' do
        expect do
          get '/user', headers: { 'Authorization' => 'unauthorized_user' }
        end.to raise_exception Bragi::ApplicationController::InvalidAuth
      end
    end
  end
end
