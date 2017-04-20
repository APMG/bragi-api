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

module Wojxorfgax
  class User < ApplicationRecord
    has_many :items, foreign_key: :wojxorfgax_user_id
  end
end
