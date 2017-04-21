# frozen_string_literal: true

require 'rails_helper'

require 'support/mock_auth_plugin'

module Wojxorfgax
  RSpec.describe 'Items API', type: :request do
    before :each do
      Wojxorfgax.config do |c|
        c.auth_plugin = MockAuthPlugin.new
      end
    end

    let!(:user) { create :wojxorfgax_user, external_uid: '12345' }

    describe 'GET #index' do
      it 'returns empty set' do
        get '/items', headers: { 'Authorization' => 'authorized_user' }
        expect(response).to have_http_status(200)

        json = JSON.parse response.body
        expect(json['data']).to eq []
      end

      context 'with multiple items' do
        let!(:items) { create_list :wojxorfgax_item, 10, user: user }

        it 'returns several items' do
          get '/items', headers: { 'Authorization' => 'authorized_user' }
          expect(response).to have_http_status(200)

          json = JSON.parse response.body
          expect(json['data'].size).to eq 10

          first_item = json['data'].first
          expect(first_item.keys).to eq %w(id type attributes)
          expect(first_item['type']).to eq 'wojxorfgax-items'
        end
      end

      context 'with unauthorized user' do
        it 'returns error' do
          expect do
            get '/items', headers: { 'Authorization' => 'unauthorized_user' }
          end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
        end
      end
    end

    describe 'GET #show' do
      it 'returns 404' do
        expect do
          get '/items/12345', headers: { 'Authorization' => 'authorized_user' }
        end.to raise_exception ActiveRecord::RecordNotFound
      end

      context 'with item' do
        let!(:item) { create :wojxorfgax_item, user: user, audio_identifier: '01/01/01/blah' }

        it 'returns item' do
          get "/items/#{'01/01/01/blah'}", headers: { 'Authorization' => 'authorized_user' }
          expect(response).to have_http_status(200)

          json = JSON.parse response.body
          expect(json['data'].size).to eq 1

          first_item = json['data'].first
          expect(first_item.keys).to eq %w(id type attributes)
          expect(first_item['id']).to eq '01/01/01/blah'
          expect(first_item['type']).to eq 'wojxorfgax-items'
        end
      end

      context 'with unauthorized user' do
        it 'returns error' do
          expect do
            get '/items/12345', headers: { 'Authorization' => 'unauthorized_user' }
          end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
        end
      end
    end

    describe 'PATCH #update' do
      it 'supports 404'
      it 'supports update'

      context 'with unauthorized user' do
        it 'returns error' do
          expect do
            patch '/items/12345', headers: { 'Authorization' => 'unauthorized_user' }
          end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
        end
      end
    end

    describe 'POST #create' do
      it 'supports creation'

      context 'with unauthorized user' do
        it 'returns error' do
          expect do
            post '/items', headers: { 'Authorization' => 'unauthorized_user' }
          end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:item) { create :wojxorfgax_item, audio_identifier: '12345', user: user }

      it 'supports 404' do
        expect do
          delete '/items/123456', headers: { 'Authorization' => 'authorized_user' }
        end.to raise_exception ActiveRecord::RecordNotFound
      end

      it 'supports deletion' do
        delete '/items/12345', headers: { 'Authorization' => 'authorized_user' }
        expect(response).to have_http_status(204)
        expect(Item.count).to eq 0
      end

      context 'with unauthorized user' do
        it 'returns error' do
          expect do
            delete '/items/12345', headers: { 'Authorization' => 'unauthorized_user' }
          end.to raise_exception Wojxorfgax::ApplicationController::InvalidAuth
        end
      end
    end
  end
end
