class Task < ApplicationRecord
  validates :title, presence: true
  validates :is_done, :inclusion => [true, false]

  belongs_to :user
  belongs_to :project, optional: true
  has_many :issues
  has_many :tags, through: :issues
end
