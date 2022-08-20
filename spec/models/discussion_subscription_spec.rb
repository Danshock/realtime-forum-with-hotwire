require 'rails_helper'

RSpec.describe DiscussionSubscription, type: :model do
  let(:discussion_subscription_optin) do
    FactoryBot.create(:discussion_subscription, :optin)
  end

  let(:discussion_subscription_optout) do
    FactoryBot.create(:discussion_subscription, :optout)
  end

  it { should belong_to(:discussion) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:subscription_type) }
  it {
    should validate_inclusion_of(:subscription_type)
      .in_array(%w[optin optout])
  }

  context '#toggle!' do
    it 'changes the subscription_type from optin to optout' do
      discussion_subscription_optin.toggle!
      expect(discussion_subscription_optin.subscription_type).to eq('optout')
    end

    it 'changes the subscription_type from optout to optin' do
      discussion_subscription_optout.toggle!
      expect(discussion_subscription_optout.subscription_type).to eq('optin')
    end
  end
end
