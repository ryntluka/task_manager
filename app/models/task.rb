class Task < ApplicationRecord
  validates :title, presence: true
  validates :is_done, :inclusion => [true, false]

  belongs_to :user
  belongs_to :project, optional: true
  has_many :issues
  has_many :tags, through: :issues
  accepts_nested_attributes_for :issues

  scope :active, -> { where is_done: false }
  scope :filter_by_done, ->(done) { where is_done: done }
  scope :search_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
end
