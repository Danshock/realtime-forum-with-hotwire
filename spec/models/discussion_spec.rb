# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discussion, type: :model do
  subject { FactoryBot.create(:discussion) }
  let(:discussion_subscription) do
    FactoryBot.create(
      :discussion_subscription, :optin, discussion_id: subject.id
    )
  end
  let(:user) { discussion_subscription.user }

  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:users).through(:posts) }
  it { should have_many(:optin_subscribers).through(:discussion_subscriptions) }
  it { should have_many(:optout_subscribers).through(:discussion_subscriptions) }
  it { should have_many(:discussion_subscriptions).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should accept_nested_attributes_for(:posts) }

  context '#to_param' do
    let(:expected_url) do
      "#{subject.id}-#{subject.name.downcase.to_s[0...50]}".parameterize
    end

    it 'outputs a friendly url' do
      expect(subject.to_param).to eq(expected_url)
    end
  end

  context '#subscribed_users' do
    it 'returns an array with subscribers' do
      expect(subject.subscribed_users).to be_a(Array)
    end
  end

  context '#subscription_for' do
    let(:user_nil) { nil }

    it 'finds a discussion a user is subscribed for' do
      expect(subject.subscription_for(user)).to be_instance_of(DiscussionSubscription)
    end

    it 'returns nil when user is nil' do
      expect(subject.subscription_for(user_nil)).to be_nil
    end
  end
end
