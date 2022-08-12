# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  it { should have_many(:discussions).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
end
