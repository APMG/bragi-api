# frozen_string_literal: true

require 'rails_helper'

require 'support/mock_auth_plugin'

module Wojxorfgax
  RSpec.describe 'Users API', type: :request do
    before :each do
      Wojxorfgax.config do |c|
        c.auth_plugin = MockAuthPlugin.new
      end
    end

    let!(:user) { create :wojxorfgax_user, external_uid: '12345' }

    describe 'GET #show' do
      it 'returns http success' do
        get '/user', headers: { 'Authorization' => 'authorized_user' }
        expect(response).to have_http_status(200)

        json = JSON.parse response.body
        expect(json['external_uid']).to eq '12345'
        expect(json['secret_uid']).to eq 'MyString'
      end

      it 'returns error on unauthenticated response' do
        expect do
          get '/user', headers: { 'Authorization' => 'unauthorized_user' }
        end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
      end
    end
  end
end
