# frozen_string_literal: true

# == Schema Information
#
# Table name: wojxorfgax_users
#
#  id           :integer          not null, primary key
#  external_uid :string(255)      not null
#  secret_uid   :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :wojxorfgax_user, class: 'Wojxorfgax::User' do
    external_uid 'MyString'
    secret_uid 'MyString'
  end
end
