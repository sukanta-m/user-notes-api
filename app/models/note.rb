class Note < ApplicationRecord
  acts_as_taggable_on :tags
  scope :by_join_date, -> { order("created_at DESC") }

  belongs_to :user
end
