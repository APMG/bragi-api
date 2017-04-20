# frozen_string_literal: true

# == Schema Information
#
# Table name: wojxorfgax_items
#
#  id                 :integer          not null, primary key
#  sort               :float(24)
#  audio_identifier   :string(255)      not null
#  audio_url          :string(255)      not null
#  audio_title        :string(255)      not null
#  audio_description  :text(65535)
#  audio_hosts        :text(65535)
#  audio_program      :string(255)
#  origin_url         :string(255)
#  source             :string(255)      not null
#  playtime           :integer          not null
#  status             :string(255)      not null
#  finished           :datetime
#  wojxorfgax_user_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :wojxorfgax_item, class: 'Wojxorfgax::Item' do
    sort 1.5
    audio_identifier 'MyString'
    audio_url 'MyString'
    audio_title 'MyString'
    audio_description 'MyText'
    audio_hosts 'MyText'
    audio_program 'MyString'
    origin_url 'MyString'
    source 'MyString'
    playtime 1
    status 'MyString'
    finished '2017-04-20 12:24:20'
    user nil
  end
end
