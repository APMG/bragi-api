# frozen_string_literal: true

# == Schema Information
#
# Table name: bragi_users
#
#  id           :integer          not null, primary key
#  external_uid :string(255)      not null
#  secret_uid   :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :bragi_user, class: 'Bragi::User' do
    external_uid 'MyString'
    secret_uid 'MyString'
  end
end
