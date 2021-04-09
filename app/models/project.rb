class Project < ApplicationRecord
  validates :title, presence: true
  validates :position, presence: true

  has_many :tasks
  belongs_to :user

  scope :search_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
end
