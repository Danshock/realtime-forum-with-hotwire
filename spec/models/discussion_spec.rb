# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discussion, type: :model do
  subject { FactoryBot.create(:discussion) }

  it { should belong_to(:user) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should validate_presence_of(:name) }

  context '#to_param' do
    let(:expected_url) do
      "#{subject.id}-#{subject.name.downcase.to_s[0...50]}".parameterize
    end

    it 'outputs a friendly url' do
      expect(subject.to_param).to eq(expected_url)
    end
  end
end
