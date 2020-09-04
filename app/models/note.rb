class Note < ApplicationRecord
  acts_as_taggable_on :tags
  scope :order_by_date, -> { order("created_at DESC") }

  validates_presence_of :body
  validates :title, presence: true, uniqueness: { case_sensetive: false, scope: :user_id }

  belongs_to :user

  def self.search(search)
    if search.present?
      where("notes.title ILIKE ? OR notes.body LIKE ?", "%#{search}%", "%#{search}%").order_by_date
    else
      order_by_date
    end
  end
end
