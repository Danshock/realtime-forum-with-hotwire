# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:discussion) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
end
