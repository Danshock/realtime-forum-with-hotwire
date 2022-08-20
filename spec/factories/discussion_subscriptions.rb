# frozen_string_literal: true

FactoryBot.define do
  factory :discussion_subscription do
    discussion
    user
    trait :optin do
      subscription_type { 'optin' }
    end

    trait :optout do
      subscription_type { 'optout' }
    end
  end
end
