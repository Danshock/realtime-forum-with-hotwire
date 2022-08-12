# frozen_string_literal: true

class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates_presence_of :name

  def to_param
    "#{id}-#{name.downcase.to_s[0...50]}".parameterize
  end
end
