# frozen_string_literal: true

FactoryBot.define do
  factory :discussion do
    name { Faker::Mountain.name }
    pinned { false }
    closed { false }
    user
    category
  end
end
