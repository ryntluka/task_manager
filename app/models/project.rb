class Project < ApplicationRecord
  validates :title, presence: true
  validates :position, presence: true, :numericality => { :greater_than => 0 }

  has_many :tasks, dependent: :destroy
  belongs_to :user

  scope :search_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
end
