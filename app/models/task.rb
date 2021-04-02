class Task < ApplicationRecord
  validates :title, presence: true
  validates :is_done, presence: true

  belongs_to :user
  belongs_to :project, optional: true
  has_many :tags, through: :issues
end
