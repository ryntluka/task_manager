class Tag < ApplicationRecord
  validates :title, presence: true

  has_many :issues
  has_many :tasks, through: :issues
  accepts_nested_attributes_for :issues
  belongs_to :user

  scope :search_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
end
