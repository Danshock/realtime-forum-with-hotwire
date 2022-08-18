# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Foo' }
    discussions_count { 1 }
  end
end
