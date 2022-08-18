# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :discussion, counter_cache: true, touch: true
  belongs_to :user, default: -> { Current.user }
  has_rich_text :body

  validates_presence_of :body

  after_create_commit lambda {
                        broadcast_append_to discussion,
                                            partial: 'discussions/posts/post',
                                            locals: { post: self }
                      }
end
