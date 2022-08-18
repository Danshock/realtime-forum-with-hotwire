# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { FactoryBot.create(:category) }

  it { should have_many(:discussions).dependent(:nullify) }

  context '#to_param' do
    let(:expected_url) do
      "#{subject.id}-#{subject.name.downcase.to_s[0...50]}".parameterize
    end

    it 'outputs a friendly url' do
      expect(subject.to_param).to eq(expected_url)
    end
  end
end
